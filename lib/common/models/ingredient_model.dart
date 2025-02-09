class IngredientModel {
  final String id;
  final String name;
  final double weight;
  final double retailPrice;
  final double usedWeight;

  IngredientModel({
    required this.id,
    required this.name,
    required this.weight,
    required this.retailPrice,
    required this.usedWeight,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'weight': weight,
      'retailPrice': retailPrice,
      'usedWeight': usedWeight,
    };
  }

  factory IngredientModel.fromMap(Map<String, dynamic> map, String id) {
    return IngredientModel(
      id: id,
      name: map['name'],
      weight: map['weight'],
      retailPrice: map['retailPrice'],
      usedWeight: map['usedWeight'],
    );
  }
}