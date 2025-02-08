import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:startcomm/common/models/balances_model.dart';
import 'package:startcomm/common/models/transaction_model.dart';
import 'package:startcomm/services/db_firestore.dart';
import 'package:flutter/foundation.dart';

abstract class TransactionRepository {
  Future<void> addTransaction(TransactionModel transaction);
  Future<void> updateTransaction(TransactionModel transaction);
  Future<List<TransactionModel>> getAllTransactions();
  Future<BalancesModel> getBalances();
}

class TransactionRepositoryImpl implements TransactionRepository {
  final FirebaseFirestore _firestore = DBFirestore.get();

  @override
  Future<void> addTransaction(TransactionModel transaction) async {
    debugPrint('TransactionRepository: Adding transaction');
    await _firestore.collection('transactions').add(transaction.toMap());
    debugPrint('TransactionRepository: Transaction added');
  }

  @override
  Future<void> updateTransaction(TransactionModel transaction) async {
    debugPrint('TransactionRepository: Updating transaction');
    await _firestore.collection('transactions').doc(transaction.id).update(transaction.toMap());
    debugPrint('TransactionRepository: Transaction updated');
  }

  @override
  Future<List<TransactionModel>> getAllTransactions() async {
    debugPrint('TransactionRepository: Getting all transactions');
    final querySnapshot = await _firestore.collection('transactions').get();
    debugPrint('TransactionRepository: Transactions retrieved');
    return querySnapshot.docs.map((doc) {
      return TransactionModel.fromMap(doc.data(), doc.id);
    }).toList();
  }

  @override
  Future<BalancesModel> getBalances() async {
    debugPrint('TransactionRepository: Getting balances');
    try {
      final querySnapshot = await _firestore.collection('transactions').get();
      double totalIncome = 0;
      double totalOutcome = 0;

      for (var doc in querySnapshot.docs) {
        final transaction = TransactionModel.fromMap(doc.data(), doc.id);
        if (transaction.value > 0) {
          totalIncome += transaction.value;
        } else {
          totalOutcome += transaction.value;
        }
      }

      final totalBalance = totalIncome + totalOutcome;
      final balances = BalancesModel(
        totalIncome: totalIncome,
        totalOutcome: totalOutcome,
        totalBalance: totalBalance,
      );

      debugPrint('TransactionRepository: Balances calculated');
      return balances;
    } catch (e) {
      debugPrint('TransactionRepository: Error getting balances - ${e.toString()}');
      throw Exception('Failed to get balances: $e');
    }
  }
}