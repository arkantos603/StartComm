import 'package:flutter/material.dart';
import 'package:startcomm/common/models/ingredient_model.dart';
import 'package:startcomm/features/products/products_edit/ingredient_state.dart';
import 'package:startcomm/repositories/ingredient_repository.dart';

class IngredientsController extends ChangeNotifier {
  final IngredientRepository _ingredientRepository;

  IngredientsController(this._ingredientRepository);

  IngredientsState _state = IngredientsInitial();
  IngredientsState get state => _state;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _retailPriceController = TextEditingController();
  final TextEditingController _usedWeightController = TextEditingController();

  TextEditingController get nameController => _nameController;
  TextEditingController get weightController => _weightController;
  TextEditingController get retailPriceController => _retailPriceController;
  TextEditingController get usedWeightController => _usedWeightController;

  Future<void> addIngredient(IngredientModel ingredient) async {
    _state = IngredientsLoading();
    notifyListeners();

    try {
      await _ingredientRepository.addIngredient(ingredient);
      await loadIngredients(); // Recarregar os ingredientes após adicionar
    } catch (e) {
      _state = IngredientsError(e.toString());
      notifyListeners();
    }
  }

  Future<void> updateIngredient(IngredientModel ingredient) async {
    _state = IngredientsLoading();
    notifyListeners();

    try {
      await _ingredientRepository.updateIngredient(ingredient);
      await loadIngredients(); // Recarregar os ingredientes após atualizar
    } catch (e) {
      _state = IngredientsError(e.toString());
      notifyListeners();
    }
  }

  Future<void> deleteIngredient(String ingredientId) async {
    _state = IngredientsLoading();
    notifyListeners();

    try {
      await _ingredientRepository.deleteIngredient(ingredientId);
      await loadIngredients(); // Recarregar os ingredientes após deletar
    } catch (e) {
      _state = IngredientsError(e.toString());
      notifyListeners();
    }
  }

  Future<void> loadIngredients() async {
    _state = IngredientsLoading();
    notifyListeners();

    try {
      final ingredients = await _ingredientRepository.getIngredients();
      _state = IngredientsLoaded(ingredients);
    } catch (e) {
      _state = IngredientsError(e.toString());
    }

    notifyListeners();
  }
}