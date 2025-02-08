import 'package:flutter/material.dart';
import 'package:startcomm/common/models/transaction_model.dart';
import 'package:startcomm/common/models/balances_model.dart';
import 'package:startcomm/repositories/transaction_repository.dart';
import 'transaction_state.dart';

class TransactionController extends ChangeNotifier {
  final TransactionRepository transactionRepository;

  TransactionController(this.transactionRepository);

  TransactionState _state = TransactionStateInitial();
  TransactionState get state => _state;

  BalancesModel? _balances;
  BalancesModel? get balances => _balances;

  Future<void> addTransaction(TransactionModel transaction) async {
    _state = TransactionStateLoading();
    notifyListeners();
    debugPrint('TransactionController: Adding transaction');

    try {
      await transactionRepository.addTransaction(transaction);
      _state = TransactionStateSuccess();
      debugPrint('TransactionController: Transaction added successfully');
    } catch (e) {
      _state = TransactionStateError(e.toString());
      debugPrint('TransactionController: Error adding transaction - ${e.toString()}');
    }

    notifyListeners();
  }

  Future<void> updateTransaction(TransactionModel transaction) async {
    _state = TransactionStateLoading();
    notifyListeners();
    debugPrint('TransactionController: Updating transaction');

    try {
      await transactionRepository.updateTransaction(transaction);
      _state = TransactionStateSuccess();
      debugPrint('TransactionController: Transaction updated successfully');
    } catch (e) {
      _state = TransactionStateError(e.toString());
      debugPrint('TransactionController: Error updating transaction - ${e.toString()}');
    }

    notifyListeners();
  }

  Future<void> getBalances() async {
    _state = TransactionStateLoading();
    notifyListeners();
    debugPrint('TransactionController: Getting balances');

    try {
      final balances = await transactionRepository.getBalances();
      _balances = balances;
      _state = TransactionStateSuccess();
      debugPrint('TransactionController: Balances retrieved successfully');
    } catch (e) {
      _state = TransactionStateError(e.toString());
      debugPrint('TransactionController: Error getting balances - ${e.toString()}');
    }

    notifyListeners();
  }
}