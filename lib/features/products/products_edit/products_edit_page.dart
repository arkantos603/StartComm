import 'package:flutter/material.dart';
import 'package:startcomm/common/constants/app_colors.dart';
import 'package:startcomm/common/extensions/sizes.dart';
import 'package:startcomm/common/models/products_model.dart';
import 'package:startcomm/common/widgets/app_header.dart';
import 'package:startcomm/common/widgets/primary_button.dart';
import 'package:startcomm/common/models/ingredient_model.dart';
import 'package:startcomm/repositories/ingredient_repository.dart';
import 'package:startcomm/features/products/products_edit/ingredient_controller.dart';
import 'package:startcomm/features/products/products_edit/ingredient_state.dart';
import 'package:provider/provider.dart';

class ProductsEditPage extends StatefulWidget {
  final ProductModel product;

  const ProductsEditPage({super.key, required this.product});

  @override
  State<ProductsEditPage> createState() => _ProductsEditPageState();
}

class _ProductsEditPageState extends State<ProductsEditPage> {
  final _formKey = GlobalKey<FormState>();
  late IngredientsController _ingredientsController;

  @override
  void initState() {
    super.initState();
    _ingredientsController = IngredientsController(IngredientRepository());
    _ingredientsController.loadIngredients(widget.product.id);
  }

  double _calculateTotalCost() {
    if (_ingredientsController.state is IngredientsLoaded) {
      final ingredients = (_ingredientsController.state as IngredientsLoaded).ingredients;
      return ingredients.fold(0.0, (total, ingredient) => total + ingredient.cost);
    }
    return 0.0;
  }

  double _calculateProfitPercentage(double totalCost) {
    if (widget.product.price > 0) {
      return ((widget.product.price - totalCost) / widget.product.price) * 100;
    }
    return 0.0;
  }

  @override
  void dispose() {
    _ingredientsController.dispose();
    super.dispose();
  }

  void _showAddIngredientDialog({IngredientModel? ingredient, int? index}) {
    if (ingredient != null) {
      _ingredientsController.nameController.text = ingredient.name;
      _ingredientsController.weightController.text = ingredient.weight.toString();
      _ingredientsController.retailPriceController.updateValue(ingredient.retailPrice);
      _ingredientsController.usedWeightController.text = ingredient.usedWeight.toString();
    } else {
      _ingredientsController.nameController.clear();
      _ingredientsController.weightController.clear();
      _ingredientsController.retailPriceController.clear();
      _ingredientsController.usedWeightController.clear();
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
                controller: _ingredientsController.nameController,
                decoration: InputDecoration(labelText: 'Nome do Ingrediente'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Esse campo não pode ser vazio.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _ingredientsController.weightController,
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
                controller: _ingredientsController.retailPriceController,
                decoration: InputDecoration(labelText: 'Preço de Varejo'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (_ingredientsController.retailPriceController.numberValue <= 0) {
                    return 'Esse campo não pode ser vazio.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _ingredientsController.usedWeightController,
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
                  name: _ingredientsController.nameController.text,
                  weight: double.parse(_ingredientsController.weightController.text),
                  retailPrice: _ingredientsController.retailPriceController.numberValue,
                  usedWeight: double.parse(_ingredientsController.usedWeightController.text),
                  productId: widget.product.id,
                );

                if (ingredient == null) {
                  await _ingredientsController.addIngredient(ingredientModel);
                } else {
                  await _ingredientsController.updateIngredient(ingredientModel);
                }

                if (mounted) {
                  await _ingredientsController.loadIngredients(widget.product.id);
                  setState(() {}); // Atualizar a UI após carregar os ingredientes
                  if (!context.mounted) return;
                  Navigator.of(context).pop();                
                }
              }
            },
          ),
        ],
      ),
    );
  }

  void _deleteIngredient(String ingredientId) async {
    await _ingredientsController.deleteIngredient(ingredientId, widget.product.id);
    await _ingredientsController.loadIngredients(widget.product.id);
    if (mounted) {
      setState(() {}); // Atualizar a UI após deletar o ingrediente
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _ingredientsController,
      child: Scaffold(
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
                    Text(
                      'Valor atual do produto: R\$${widget.product.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Consumer<IngredientsController>(
                      builder: (context, controller, child) {
                        final totalCost = _calculateTotalCost();
                        final profitPercentage = _calculateProfitPercentage(totalCost);
                        return Column(
                            children: [
                            Text(
                              'Total gasto em ingredientes: R\$${totalCost.toStringAsFixed(2)}',
                              style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              'Lucro de venda: ${profitPercentage.toStringAsFixed(2)}%',
                              style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: AppColors.darkGreen,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    Expanded(
                      child: Consumer<IngredientsController>(
                        builder: (context, controller, child) {
                          if (controller.state is IngredientsLoading) {
                            return Center(child: CircularProgressIndicator());
                          } else if (controller.state is IngredientsLoaded) {
                            final ingredients = (controller.state as IngredientsLoaded).ingredients;
                            return ListView.builder(
                              itemCount: ingredients.length,
                              itemBuilder: (context, index) {
                                final ingredient = ingredients[index];
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
                                      'Peso: ${ingredient.weight}g, Preço: R\$${ingredient.retailPrice}, Utilizado: ${ingredient.usedWeight}g, Custo por unidade de ${widget.product.name}: R\$${ingredient.cost.toStringAsFixed(2)}'),
                                );
                              },
                            );
                          } else {
                            return Center(child: Text('Erro ao carregar ingredientes'));
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}