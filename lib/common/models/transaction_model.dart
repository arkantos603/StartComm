class TransactionModel {
  final String id;
  final String category;
  final String description;
  final double value;
  final int date;
  final int createdAt;
  final bool status;

  TransactionModel({
    required this.id,
    required this.category,
    required this.description,
    required this.value,
    required this.date,
    required this.createdAt,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category': category,
      'description': description,
      'value': value,
      'date': date,
      'createdAt': createdAt,
      'status': status,
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map, String id) {
    return TransactionModel(
      id: id,
      category: map['category'] ?? '',
      description: map['description'] ?? '',
      value: map['value']?.toDouble() ?? 0.0,
      date: map['date']?.toInt() ?? 0,
      createdAt: map['createdAt']?.toInt() ?? 0,
      status: map['status'] ?? false,
    );
  }
}