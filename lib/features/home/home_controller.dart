import 'package:flutter/material.dart';
import 'package:startcomm/common/models/transaction_model.dart';
import 'package:startcomm/features/home/home_state.dart';
import 'package:startcomm/features/map/map_page.dart';
import 'package:startcomm/repositories/transaction_repository.dart';
import 'package:startcomm/features/home/home_page.dart';
import 'package:startcomm/features/caixa/caixa_page.dart';
import 'package:startcomm/features/products/products_page.dart';

class HomeController extends ChangeNotifier {
  final TransactionRepository _transactionRepository;
  HomeController(this._transactionRepository) {
    _initialize();
  }

  HomeState _state = HomeStateInitial();
  HomeState get state => _state;

  List<TransactionModel> _transactions = [];
  List<TransactionModel> get transactions => _transactions;

  late PageController pageController;
  late List<Widget> pages;

  void _initialize() {
    pageController = PageController();
    pages = [
      HomePage(),
      CaixaPage(),
      ProductsPage(),
      MapPage(),
    ];
  }

  void _changeState(HomeState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<void> getAllTransactions() async {
    _changeState(HomeStateLoading());
    try {
      _transactions = await _transactionRepository.getAllTransactions();
      _changeState(HomeStateSuccess());
    } catch (e) {
      _changeState(HomeStateError());
    }
  }

  double get totalIncome => _transactions
      .where((transaction) => transaction.value > 0)
      .fold(0.0, (sum, transaction) => sum + transaction.value);

  double get totalExpense => _transactions
      .where((transaction) => transaction.value < 0)
      .fold(0.0, (sum, transaction) => sum + transaction.value);

  double get accountBalance => totalIncome + totalExpense;
}