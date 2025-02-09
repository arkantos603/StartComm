import 'package:flutter/material.dart';
import 'package:startcomm/common/extensions/sizes.dart';
import 'package:startcomm/common/widgets/primary_button.dart';
import '../../common/constants/app_colors.dart';
import '../../common/models/products_model.dart';
import '../../common/widgets/app_header.dart';

class ProductsEditPage extends StatefulWidget {
  final ProductModel product;

  const ProductsEditPage({super.key, required this.product});

  @override
  State<ProductsEditPage> createState() => _ProductsEditPageState();
}

class _ProductsEditPageState extends State<ProductsEditPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.product.name;
    _priceController.text = widget.product.price.toString();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AppHeader(
            title: 'Edição Avançada',
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
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
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
                        if (value == null || value.isEmpty) {
                          return 'Esse campo não pode ser vazio.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    PrimaryButton(
                      text: 'Salvar',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Lógica para salvar as alterações
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}