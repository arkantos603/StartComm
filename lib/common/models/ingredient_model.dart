class IngredientModel {
  final String id;
  final String name;
  final double weight;
  final double retailPrice;
  final double usedWeight;
  final String productId;
  final double cost;

  IngredientModel({
    required this.id,
    required this.name,
    required this.weight,
    required this.retailPrice,
    required this.usedWeight,
    required this.productId,
  }) : cost = (retailPrice / weight) * usedWeight;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'weight': weight,
      'retailPrice': retailPrice,
      'usedWeight': usedWeight,
      'productId': productId,
      'cost': cost,
    };
  }

  factory IngredientModel.fromMap(Map<String, dynamic> map, String id) {
    return IngredientModel(
      id: id,
      name: map['name'],
      weight: map['weight'],
      retailPrice: map['retailPrice'],
      usedWeight: map['usedWeight'],
      productId: map['productId'],
    );
  }
}