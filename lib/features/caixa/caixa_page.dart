import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:startcomm/common/constants/app_texts.dart';
import 'package:startcomm/common/widgets/custom_snackbar.dart';
import 'package:startcomm/features/products/products_controller.dart';
import 'package:startcomm/features/products/products_state.dart';
import '../../common/constants/app_colors.dart';
import '../../common/extensions/date_formatter.dart';
import '../../common/extensions/sizes.dart';
import '../../common/models/transaction_model.dart';
import '../../common/utils/money_mask_controller.dart';
import '../../common/widgets/app_header.dart';
import '../../common/widgets/custom_circular_progress_indicator.dart';
import '../../common/widgets/custom_text_form_field.dart';
import '../../common/widgets/primary_button.dart';
import '../../locator.dart';
import 'transaction_controller.dart';
import 'transaction_state.dart';

class CaixaPage extends StatefulWidget {
  final TransactionModel? transaction;
  const CaixaPage({
    super.key,
    this.transaction,
  });

  @override
  State<CaixaPage> createState() => _CaixaPageState();
}

class _CaixaPageState extends State<CaixaPage>
    with SingleTickerProviderStateMixin, CustomSnackBar {
  final _transactionController = locator.get<TransactionController>();
  final _productsController = locator.get<ProductsController>();

  final _formKey = GlobalKey<FormState>();

  final _outcomes = ['Salário', 'Contas', 'Outros'];
  DateTime? _newDate;
  bool value = false;

  final _descriptionController = TextEditingController();
  final _categoryController = TextEditingController();
  final _dateController = TextEditingController();
  final _amountController = MoneyMaskedTextController(
    prefix: 'R\$',
  );

  late final TabController _tabController;

  int get _initialIndex {
    if (widget.transaction != null && widget.transaction!.value.isNegative) {
      return 1;
    }

    return 0;
  }

  String get _date {
    if (widget.transaction?.date != null) {
      return DateTime.fromMillisecondsSinceEpoch(widget.transaction!.date)
          .toText;
    } else {
      return '';
    }
  }

  @override
  void initState() {
    super.initState();
    _amountController.updateValue(widget.transaction?.value ?? 0);
    value = widget.transaction?.status ?? false;
    _descriptionController.text = widget.transaction?.description ?? '';
    _categoryController.text = widget.transaction?.category ?? '';
    _newDate =
        DateTime.fromMillisecondsSinceEpoch(widget.transaction?.date ?? 0);
    _dateController.text = widget.transaction?.date != null
        ? DateTime.fromMillisecondsSinceEpoch(widget.transaction!.date).toText
        : '';
    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: _initialIndex,
    );

    _transactionController.addListener(() {
      if (_transactionController.state is TransactionStateLoading) {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => const CustomCircularProgressIndicator(),
        );
      }
      if (_transactionController.state is TransactionStateSuccess) {
        if (mounted) {
          Navigator.of(context).pop();
          _showSuccessMessage(); // Mostrar mensagem de sucesso
        }
      }
      if (_transactionController.state is TransactionStateError) {
        final error = _transactionController.state as TransactionStateError;
        showCustomSnackBar(
          context: context,
          text: error.message,
          type: SnackBarType.error,
        );
      }
    });

    _productsController.addListener(_onProductsStateChanged);
    _productsController.loadProducts();
  }

  Future<void> _showSuccessMessage() async {
    final isIncome = _tabController.index == 0;
    final message = isIncome
        ? 'Receita adicionada com sucesso!'
        : 'Despesa adicionada com sucesso!';

    if (!mounted) return;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Sucesso'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              if (mounted) {
                Navigator.of(context).pop(); // Fechar o diálogo
                Navigator.of(context).pop(true); // Navegar de volta para a HomePage
              }
            },
            child: Text('Voltar'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _amountController.dispose();
    _descriptionController.dispose();
    _categoryController.dispose();
    _dateController.dispose();
    _transactionController.dispose();
    _productsController.removeListener(_onProductsStateChanged);
    super.dispose();
  }

  void _onProductsStateChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  void _onCategorySelected(String category) {
    if (category == 'Outros') {
      _amountController.updateValue(0);
    } else if (_tabController.index == 0) {
      final product = (_productsController.state as ProductsLoaded).products
          .firstWhere((product) => product.name == category);
      _amountController.updateValue(product.price);
    }
    _categoryController.text = category;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AppHeader(
            title: widget.transaction != null
                ? 'Editar Movimentação'
                : 'Adicionar Movimentação',
          ),
          Positioned(
            top: 164.h,
            left: 28.w,
            right: 28.w,
            bottom: 16.h,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      StatefulBuilder(
                        builder: (context, setState) {
                          return TabBar(
                            labelPadding: EdgeInsets.zero,
                            controller: _tabController,
                            onTap: (_) {
                              if (_tabController.indexIsChanging) {
                                setState(() {});
                              }
                              if (_tabController.indexIsChanging &&
                                  _categoryController.text.isNotEmpty) {
                                _categoryController.clear();
                                _amountController.updateValue(0);
                              }
                            },
                            tabs: [
                              Tab(
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: _tabController.index == 0
                                        ? AppColors.iceWhite
                                        : AppColors.white,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(24.0),
                                    ),
                                  ),
                                  child: Text(
                                    'Receita',
                                    style: AppTextStyles.mediumText16w500
                                        .apply(color: AppColors.darkGrey),
                                  ),
                                ),
                              ),
                              Tab(
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: _tabController.index == 1
                                        ? AppColors.iceWhite
                                        : AppColors.white,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(24.0),
                                    ),
                                  ),
                                  child: Text(
                                    'Despesa',
                                    style: AppTextStyles.mediumText16w500
                                        .apply(color: AppColors.darkGrey),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 16.0),
                      CustomTextFormField(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        controller: _categoryController,
                        readOnly: true,
                        labelText: "Categoria",
                        hintText: "Selecione uma categoria",
                        validator: (value) {
                          if (_categoryController.text.isEmpty) {
                            return 'Esse campo não pode ser vazio.';
                          }
                          return null;
                        },
                        onTap: () => showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            if (_productsController.state is ProductsLoaded) {
                              final products = (_productsController.state as ProductsLoaded).products;
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: (_tabController.index == 0
                                        ? products.map((product) => product.name).toList() + ['Outros']
                                        : _outcomes)
                                    .map(
                                      (e) => TextButton(
                                        onPressed: () {
                                          _onCategorySelected(e);
                                          Navigator.pop(context);
                                        },
                                        child: Text(e),
                                      ),
                                    )
                                    .toList(),
                              );
                            } else {
                              return Center(child: CircularProgressIndicator());
                            }
                          },
                        ),
                      ),
                      CustomTextFormField(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        controller: _descriptionController,
                        labelText: 'Descrição',
                        hintText: 'Adicione uma descrição',
                      ),
                      CustomTextFormField(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        controller: _dateController,
                        readOnly: true,
                        labelText: "Data",
                        hintText: "Selecione uma data",
                        validator: (value) {
                          if (_dateController.text.isEmpty) {
                            return 'Esse campo não pode ser vazio.';
                          }
                          return null;
                        },
                        onTap: () async {
                          _newDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1970),
                            lastDate: DateTime(2100), // Permitir datas futuras
                          );

                          _newDate = _newDate != null
                              ? DateTime.now().copyWith(
                                  day: _newDate?.day,
                                  month: _newDate?.month,
                                  year: _newDate?.year,
                                )
                              : null;

                          _dateController.text =
                              _newDate != null ? _newDate!.toText : _date;
                        },
                      ),
                      CustomTextFormField(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        labelText: "Valor",
                        hintText: "Digite um valor",
                        validator: (value) {
                          if (_amountController.text.isEmpty) {
                            return 'Esse campo não pode ser vazio.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: PrimaryButton(
                          text: widget.transaction != null ? 'Salvar' : 'Adicionar',
                          onPressed: () async {
                            FocusScope.of(context).unfocus();
                            if (_formKey.currentState!.validate()) {
                              final newValue = double.parse(_amountController
                                  .text
                                  .replaceAll('R\$', '')
                                  .replaceAll('.', '')
                                  .replaceAll(',', '.'));

                              final now = DateTime.now().millisecondsSinceEpoch;

                              final newTransaction = TransactionModel(
                                id: widget.transaction?.id ?? '',
                                category: _categoryController.text,
                                description: _descriptionController.text,
                                value: _tabController.index == 1
                                    ? newValue * -1
                                    : newValue,
                                date: _newDate != null
                                    ? _newDate!.millisecondsSinceEpoch
                                    : now,
                                createdAt: widget.transaction?.createdAt ?? now,
                                status: value,
                              );
                              if (widget.transaction == newTransaction) {
                                Navigator.pop(context);
                                return;
                              }
                              if (widget.transaction != null) {
                                await _transactionController
                                    .updateTransaction(newTransaction);
                                if (mounted) {
                                  if (context.mounted) {
                                    Navigator.of(context).pop(true);
                                  }
                                }
                              } else {
                                await _transactionController.addTransaction(
                                  newTransaction,
                                );
                                if (mounted) {
                                  if (context.mounted) {
                                    Navigator.of(context).pop(true);
                                  }
                                }
                              }
                            } else {
                              log('invalid');
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}