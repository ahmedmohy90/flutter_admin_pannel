import 'package:get/get.dart';

class ProductVariationModel {
  final String id;
  String sku;
  Rx<String> image;
  String? description;
  double price;
  double salePrice;
  int stock;
  int soldQuantity;
  Map<String, String> attributesValues;

  ProductVariationModel({
    required this.id,
    this.sku = '',
    String image = '',
    this.description = '',
    this.price = 0.0,
    this.salePrice = 0.0,
    this.stock = 0,
    this.soldQuantity = 0,
    required this.attributesValues,
  }) : image = image.obs;

  static ProductVariationModel empty() => ProductVariationModel(
        id: '',
        attributesValues: {},
      );

      toJson() => {
            'id': id,
            'sku': sku,
            'image': image.value,
            'description': description,
            'price': price,
            'salePrice': salePrice,
            'stock': stock,
            'soldQuantity': soldQuantity,
            'attributesValues': attributesValues,
          };

          factory ProductVariationModel.fromJson(Map<String, dynamic> json) {
            return ProductVariationModel(
              id: json['id'] ?? '',
              sku: json['sku']??'',
              image: json['image'],
              description: json['description'],
            price: double.parse((json['price']?? 0).toString()),
              salePrice: json['salePrice'],
              stock: json['stock'],
              soldQuantity: json['soldQuantity'],
              attributesValues: json['attributesValues'],
            );
          }
}
