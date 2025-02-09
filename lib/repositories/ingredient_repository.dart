import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:startcomm/common/models/ingredient_model.dart';
import 'package:startcomm/services/db_firestore.dart';

class IngredientRepository {
  final FirebaseFirestore _firestore = DBFirestore.get();
  final List<IngredientModel> _ingredients = [];

  List<IngredientModel> get ingredients => List.unmodifiable(_ingredients);

  Future<void> addIngredient(IngredientModel ingredient) async {
    _ingredients.add(ingredient);
    await _firestore.collection('ingredients').add(ingredient.toMap());
  }

  Future<void> updateIngredient(IngredientModel ingredient) async {
    final index = _ingredients.indexWhere((i) => i.id == ingredient.id);
    if (index != -1) {
      _ingredients[index] = ingredient;
      await _firestore.collection('ingredients').doc(ingredient.id).update(ingredient.toMap());
    }
  }

  Future<void> deleteIngredient(String id) async {
    _ingredients.removeWhere((ingredient) => ingredient.id == id);
    await _firestore.collection('ingredients').doc(id).delete();
  }

  Future<List<IngredientModel>> getIngredients() async {
    final querySnapshot = await _firestore.collection('ingredients').get();
    _ingredients.clear();
    for (var doc in querySnapshot.docs) {
      _ingredients.add(IngredientModel.fromMap(doc.data(), doc.id));
    }
    return _ingredients;
  }
}