import 'dart:developer';

import 'package:admin_pannel/features/shop/models/brand_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../utils/formatters/formatter.dart';
import 'product_attribute_model.dart';
import 'product_variation_model.dart';

class ProductModel {
  String id;
  int stock;
  String? sku;
  double price;
  String title;
  DateTime? date;
  double salePrice;
  String thumbnail;
  bool? isFeatured;
  BrandModel? brand;
  String? categoryId;
  String productType;
  String? description;
  List<String> images;
  int soldQuantity;
  List<ProductAttributeModel> attributes;
  List<ProductVariationModel> variations;

  ProductModel({
    required this.id,
    required this.stock,
    this.sku,
    required this.price,
    required this.title,
    this.date,
    this.salePrice = 0.0,
    required this.thumbnail,
    this.isFeatured,
    this.brand,
    this.categoryId,
    required this.productType,
    this.description,
    List<String>? images,
    this.soldQuantity = 0,
    List<ProductAttributeModel>? attributes,
    List<ProductVariationModel>? variations,
  })  : images = images ?? [],
        attributes = attributes ?? [],
        variations = variations ?? [];

  String get formattedDate => TFormatter.formatDate(date);

  static ProductModel empty() => ProductModel(
        id: '',
        stock: 0,
        sku: '',
        price: 0.0,
        title: '',
        date: DateTime.now(),
        salePrice: 0.0,
        thumbnail: '',
        isFeatured: false,
        brand: null,
        categoryId: '',
        productType: '',
        description: '',
        images: [],
        soldQuantity: 0,
        attributes: [],
        variations: [],
      );

  Map<String, dynamic> toJson() {
    return {
      'stock': stock,
      'sku': sku,
      'price': price,
      'title': title,
      'date': date,
      'salePrice': salePrice,
      'thumbnail': thumbnail,
      'isFeatured': isFeatured,
      'brand': brand?.toJson(),
      'categoryId': categoryId,
      'productType': productType,
      'description': description,
      'images': images,
      'soldQuantity': soldQuantity,
      'attributes': attributes.map((e) => e.toJson()).toList(),
      'variations': variations.map((e) => e.toJson()).toList(),
    };
  }

  /// Factory method from DocumentSnapshot
  factory ProductModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    log(snapshot.data().toString());

    final data = snapshot.data() ?? {};

    return ProductModel(
      id: snapshot.id,
      stock: data['stock'] ?? 0,
      sku: data['sku'],
      price: double.parse((data['price'] ?? 0).toString()),
      title: data['title'] ?? '',
      date: data['date'] != null ? (data['date'] as Timestamp).toDate() : null,
      salePrice: double.parse((data['salePrice'] ?? 0).toString()),
      thumbnail: data['thumbnail'] ?? '',
      isFeatured: data['isFeatured'] ?? false,
      brand: data['brand'] != null ? BrandModel.fromJson(data['brand']) : null,
      categoryId: data['categoryId'],
      productType: data['productType'] ?? '',
      description: data['description'],
      images:
          data['images'] != null ? List<String>.from(data['images']) : [],
      soldQuantity: data['soldQuantity'] ?? 0,
      attributes: data['attributes'] != null
          ? List<ProductAttributeModel>.from(
              data['attributes']
                  .map((e) => ProductAttributeModel.fromJson(e)),
            )
          : [],
      variations: data['variations'] != null
          ? List<ProductVariationModel>.from(
              data['variations']
                  .map((e) => ProductVariationModel.fromJson(e)),
            )
          : [],
    );
  }

  /// Factory method from QueryDocumentSnapshot
  factory ProductModel.fromQuerySnapshot(QueryDocumentSnapshot document) {
    final data = document.data() as Map<String, dynamic>;

    return ProductModel(
      id: document.id,
      stock: data['stock'] ?? 0,
      sku: data['sku'] ?? '',
      price: double.parse((data['price'] ?? 0).toString()),
      title: data['title'] ?? '',
      date: data['date'] != null ? (data['date'] as Timestamp).toDate() : null,
      salePrice: double.parse((data['salePrice'] ?? 0).toString()),
      thumbnail: data['thumbnail'] ?? '',
      isFeatured: data['isFeatured'] ?? false,
      brand: data['brand'] != null ? BrandModel.fromJson(data['brand']) : null,
      categoryId: data['categoryId'],
      productType: data['productType'] ?? '',
      description: data['description'],
      images:
          data['images'] != null ? List<String>.from(data['images']) : [],
      soldQuantity: data['soldQuantity'] ?? 0,
      attributes: data['attributes'] != null
          ? List<ProductAttributeModel>.from(
              data['attributes']
                  .map((e) => ProductAttributeModel.fromJson(e)),
            )
          : [],
      variations: data['variations'] != null
          ? List<ProductVariationModel>.from(
              data['variations']
                  .map((e) => ProductVariationModel.fromJson(e)),
            )
          : [],
    );
  }
}
