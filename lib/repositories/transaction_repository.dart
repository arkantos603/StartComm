import 'package:startcomm/common/models/transaction_model.dart';

abstract class TransactionRepository {
  Future<void> addTransactions();
  Future<List<TransactionModel>> getAllTransactions();
}

class TransactionRepositoryImpl implements TransactionRepository {
  @override
  Future<void> addTransactions() {
    throw UnimplementedError();
  }

  @override
  Future<List<TransactionModel>> getAllTransactions() async {
    await Future.delayed(const Duration(seconds: 2));
    return [
      TransactionModel(
        title: 'Receita',
        value: 1500,
        date: DateTime.now().millisecondsSinceEpoch,
      ),
      TransactionModel(
        title: 'Despesa',
        value: -500,
        date: DateTime.now()
            .subtract(const Duration(days: 7))
            .millisecondsSinceEpoch,
      ),
    ];
  }
}
