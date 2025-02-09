import 'package:startcomm/common/models/ingredient_model.dart';

abstract class IngredientsState {}

class IngredientsInitial extends IngredientsState {}

class IngredientsLoading extends IngredientsState {}

class IngredientsLoaded extends IngredientsState {
  final List<IngredientModel> ingredients;

  IngredientsLoaded(this.ingredients);
}

class IngredientsError extends IngredientsState {
  final String message;

  IngredientsError(this.message);
}