import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:startcomm/common/models/products_model.dart';
import 'package:startcomm/services/db_firestore.dart';

class ProductRepository {
  final FirebaseFirestore _firestore = DBFirestore.get();
  final List<ProductModel> _products = [];

  List<ProductModel> get products => List.unmodifiable(_products);

  Future<void> addProduct(ProductModel product) async {
    _products.add(product);
    await _firestore.collection('products').add(product.toMap());
  }

  Future<void> updateProduct(ProductModel product) async {
    final index = _products.indexWhere((p) => p.id == product.id);
    if (index != -1) {
      _products[index] = product;
      await _firestore.collection('products').doc(product.id).update(product.toMap());
    }
  }

  Future<void> deleteProduct(String id) async {
    _products.removeWhere((product) => product.id == id);
    await _firestore.collection('products').doc(id).delete();
  }

  Future<List<ProductModel>> getProducts() async {
    final querySnapshot = await _firestore.collection('products').get();
    _products.clear();
    for (var doc in querySnapshot.docs) {
      _products.add(ProductModel.fromMap(doc.data(), doc.id));
    }
    return _products;
  }

  Future<void> loadProducts() async {
    final querySnapshot = await _firestore.collection('products').get();
    _products.clear();
    for (var doc in querySnapshot.docs) {
      _products.add(ProductModel.fromMap(doc.data(), doc.id));
    }
  }
}