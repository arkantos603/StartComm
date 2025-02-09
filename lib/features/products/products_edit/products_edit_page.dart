import 'package:flutter/material.dart';
import 'package:startcomm/common/constants/app_colors.dart';
import 'package:startcomm/common/extensions/sizes.dart';
import 'package:startcomm/common/models/products_model.dart';
import 'package:startcomm/common/widgets/app_header.dart';
import 'package:startcomm/common/widgets/primary_button.dart';
import 'package:startcomm/common/models/ingredient_model.dart';
import 'package:startcomm/repositories/ingredient_repository.dart';

class ProductsEditPage extends StatefulWidget {
  final ProductModel product;

  const ProductsEditPage({super.key, required this.product});

  @override
  State<ProductsEditPage> createState() => _ProductsEditPageState();
}

class _ProductsEditPageState extends State<ProductsEditPage> {
  final _formKey = GlobalKey<FormState>();
  final _ingredientNameController = TextEditingController();
  final _weightController = TextEditingController();
  final _retailPriceController = TextEditingController();
  final _usedWeightController = TextEditingController();
  final IngredientRepository _ingredientRepository = IngredientRepository();
  List<IngredientModel> _ingredients = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadIngredients();
  }

  Future<void> _loadIngredients() async {
    final ingredients = await _ingredientRepository.getIngredients();
    if (mounted) {
      setState(() {
        _ingredients = ingredients;
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _ingredientNameController.dispose();
    _weightController.dispose();
    _retailPriceController.dispose();
    _usedWeightController.dispose();
    super.dispose();
  }

  void _showAddIngredientDialog({IngredientModel? ingredient, int? index}) {
    if (ingredient != null) {
      _ingredientNameController.text = ingredient.name;
      _weightController.text = ingredient.weight.toString();
      _retailPriceController.text = ingredient.retailPrice.toString();
      _usedWeightController.text = ingredient.usedWeight.toString();
    } else {
      _ingredientNameController.clear();
      _weightController.clear();
      _retailPriceController.clear();
      _usedWeightController.clear();
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(ingredient == null ? 'Cadastrar Ingrediente' : 'Editar Ingrediente'),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _ingredientNameController,
                decoration: InputDecoration(labelText: 'Nome do Ingrediente'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Esse campo não pode ser vazio.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _weightController,
                decoration: InputDecoration(labelText: 'Peso em Gramas'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Esse campo não pode ser vazio.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _retailPriceController,
                decoration: InputDecoration(labelText: 'Preço de Varejo'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Esse campo não pode ser vazio.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _usedWeightController,
                decoration: InputDecoration(labelText: 'Gramatura Utilizada'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
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
            text: 'Salvar',
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                final ingredientModel = IngredientModel(
                  id: ingredient?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
                  name: _ingredientNameController.text,
                  weight: double.parse(_weightController.text),
                  retailPrice: double.parse(_retailPriceController.text),
                  usedWeight: double.parse(_usedWeightController.text),
                );

                if (mounted) {
                  Navigator.of(context).pop();
                }
                if (ingredient == null) {
                  await _ingredientRepository.addIngredient(ingredientModel);
                } else {
                  await _ingredientRepository.updateIngredient(ingredientModel);
                }

                await _loadIngredients();
              }
            },
          ),
        ],
      ),
    );
  }

  void _deleteIngredient(String ingredientId) async {
    await _ingredientRepository.deleteIngredient(ingredientId);
    await _loadIngredients();
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
            top: 120.h,
            left: 28.w,
            right: 28.w,
            child: Text(
              widget.product.name,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.iceWhite,
              ),
              textAlign: TextAlign.center,
            ),
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
                  PrimaryButton(
                    text: 'Cadastrar Ingrediente',
                    onPressed: () => _showAddIngredientDialog(),
                  ),
                  const SizedBox(height: 16.0),
                  Expanded(
                    child: _isLoading
                        ? Center(child: CircularProgressIndicator())
                        : ListView.builder(
                            itemCount: _ingredients.length,
                            itemBuilder: (context, index) {
                              final ingredient = _ingredients[index];
                              return ListTile(
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(ingredient.name),
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.edit),
                                          onPressed: () => _showAddIngredientDialog(ingredient: ingredient, index: index),
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.delete),
                                          onPressed: () => _deleteIngredient(ingredient.id),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                subtitle: Text(
                                    'Peso: ${ingredient.weight}g, Preço: R\$${ingredient.retailPrice}, Utilizado: ${ingredient.usedWeight}g'),
                              );
                            },
                          ),
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