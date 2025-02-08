import 'dart:convert';

class BalancesModel {
  final double totalIncome;
  final double totalOutcome;
  final double totalBalance;

  BalancesModel({
    required this.totalIncome,
    required this.totalOutcome,
    required this.totalBalance,
  });

  Map<String, dynamic> toMap() {
    return {
      'totalIncome': totalIncome,
      'totalOutcome': totalOutcome,
      'totalBalance': totalBalance,
    };
  }

  factory BalancesModel.fromMap(Map<String, dynamic> map) {
    return BalancesModel(
      totalIncome: map['totalIncome']?.toDouble() ?? 0.0,
      totalOutcome: map['totalOutcome']?.toDouble() ?? 0.0,
      totalBalance: map['totalBalance']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory BalancesModel.fromJson(String source) =>
      BalancesModel.fromMap(json.decode(source));
}