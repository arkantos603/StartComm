import 'package:flutter/material.dart';
import 'package:startcomm/common/extensions/sizes.dart';
import 'package:startcomm/common/widgets/custom_snackbar.dart';
import 'package:startcomm/common/widgets/primary_button.dart';
import 'package:startcomm/common/utils/money_mask_controller.dart';
import '../../common/constants/app_colors.dart';
import '../../common/models/products_model.dart';
import '../../common/widgets/app_header.dart';
import '../../locator.dart';
import 'products_controller.dart';
import 'products_state.dart';
import 'products_edit/products_edit_page.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> with CustomSnackBar {
  final _productsController = locator.get<ProductsController>();
  final _formKey = GlobalKey<FormState>();
  final _priceController = MoneyMaskedTextController(
    decimalSeparator: ',',
    thousandSeparator: '.',
    prefix: 'R\$ ',
  );

  @override
  void initState() {
    super.initState();
    _productsController.loadProducts();
    _productsController.addListener(_onProductsStateChanged);
  }

  @override
  void dispose() {
    _productsController.removeListener(_onProductsStateChanged);
    super.dispose();
  }

  void _onProductsStateChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  void _editProduct(ProductModel product) {
    _productsController.nameController.text = product.name;
    _priceController.updateValue(product.price);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Editar Produto'),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _productsController.nameController,
                decoration: InputDecoration(labelText: 'Nome do Produto'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Esse campo não pode ser vazio.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(labelText: 'Preço'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (_priceController.numberValue <= 0) {
                    return 'Esse campo não pode ser vazio.';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ProductsEditPage(product: product),
                    ),
                  );
                },
                child: Text('Edição Avançada'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancelar'),
              ),
              TextButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final name = _productsController.nameController.text;
                    final price = _priceController.numberValue;
                    if (name.isNotEmpty && price > 0) {
                      final updatedProduct = ProductModel(
                        id: product.id,
                        name: name,
                        price: price,
                      );
                      final currentContext = context;
                      await _productsController.updateProduct(updatedProduct);
                      if (mounted) {
                        setState(() {});
                        if (currentContext.mounted) {
                          Navigator.of(currentContext).pop();
                        }
                      }
                    }
                  }
                },
                child: Text('Salvar'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _deleteProduct(String productId) async {
    await _productsController.deleteProduct(productId);
    if (mounted) {
      setState(() {});
    }
  }

  void _addProduct() {
    _productsController.nameController.clear();
    _priceController.updateValue(0);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Adicionar Produto'),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _productsController.nameController,
                decoration: InputDecoration(labelText: 'Nome do Produto'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Esse campo não pode ser vazio.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(labelText: 'Preço'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (_priceController.numberValue <= 0) {
                    return 'Esse campo não pode ser vazio.';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancelar'),
          ),
          PrimaryButton(
            text: 'Adicionar',
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                final name = _productsController.nameController.text;
                final price = _priceController.numberValue;
                if (name.isNotEmpty && price > 0) {
                  final newProduct = ProductModel(
                    id: DateTime.now().millisecondsSinceEpoch.toString(), // Gerar um ID único
                    name: name,
                    price: price,
                  );
                  final currentContext = context;
                  await _productsController.addProduct(newProduct);
                  if (mounted) {
                    setState(() {});
                    if (currentContext.mounted) {
                      Navigator.of(currentContext).pop();
                    }
                  }
                }
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AppHeader(
            title: 'Produtos',
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
              child: Column(
                children: [
                  SizedBox(
                    width: 200, // Defina a largura desejada aqui
                    child: PrimaryButton(
                      text: 'Adicionar Produto',
                      onPressed: _addProduct,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Expanded(
                    child: _productsController.state is ProductsLoaded
                        ? ListView.builder(
                            itemCount: (_productsController.state as ProductsLoaded).products.length,
                            itemBuilder: (context, index) {
                              final product = (_productsController.state as ProductsLoaded).products[index];
                              return ListTile(
                                title: Text(product.name),
                                subtitle: Text('R\$ ${product.price.toStringAsFixed(2)}'),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.edit),
                                      onPressed: () => _editProduct(product),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.delete),
                                      onPressed: () => _deleteProduct(product.id),
                                    ),
                                  ],
                                ),
                              );
                            },
                          )
                        : Center(child: CircularProgressIndicator()),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}