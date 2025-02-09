import 'package:flutter/material.dart';
import 'package:startcomm/common/models/products_model.dart';
import 'package:startcomm/features/products/products_state.dart';
import 'package:startcomm/repositories/products_repository.dart';

class ProductsController extends ChangeNotifier {
  final ProductRepository _productRepository;

  ProductsController(this._productRepository);

  ProductsState _state = ProductsInitial();
  ProductsState get state => _state;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  TextEditingController get nameController => _nameController;
  TextEditingController get priceController => _priceController;

  Future<void> addProduct(ProductModel product) async {
    _state = ProductsLoading();
    notifyListeners();

    try {
      await _productRepository.addProduct(product);
      _state = ProductsLoaded(_productRepository.products);
    } catch (e) {
      _state = ProductsError(e.toString());
    }

    notifyListeners();
  }

  Future<void> updateProduct(ProductModel product) async {
    _state = ProductsLoading();
    notifyListeners();

    try {
      await _productRepository.updateProduct(product);
      _state = ProductsLoaded(_productRepository.products);
    } catch (e) {
      _state = ProductsError(e.toString());
    }

    notifyListeners();
  }

  Future<void> deleteProduct(String productId) async {
    _state = ProductsLoading();
    notifyListeners();

    try {
      await _productRepository.deleteProduct(productId);
      _state = ProductsLoaded(_productRepository.products);
    } catch (e) {
      _state = ProductsError(e.toString());
    }

    notifyListeners();
  }

  Future<void> loadProducts() async {
    _state = ProductsLoading();
    notifyListeners();

    try {
      final products = await _productRepository.getProducts();
      _state = ProductsLoaded(products);
    } catch (e) {
      _state = ProductsError(e.toString());
    }

    notifyListeners();
  }
}