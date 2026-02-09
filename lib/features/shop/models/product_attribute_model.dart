class ProductAttributeModel {
  String? name;
  final List<dynamic>? values;

  ProductAttributeModel({
    this.name,
    this.values,
  });

  toJson() {
    return {
      'name': name,
      'values': values,
    };
  }

  factory ProductAttributeModel.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) return ProductAttributeModel();
    return ProductAttributeModel(
      name: json.containsKey('name') ? json['name'] : '',
      values: List<String>.from(json['values']),
    );
  }
}
