import 'package:admin_pannel/utils/formatters/formatter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'category_model.dart';

class BrandModel {
  String id;
  String name;
  String image;
  bool isFeatured;
  int? productsCount;
  DateTime? createdAt;
  DateTime? updatedAt;

  List<CategoryModel>? brandCategories;
  BrandModel({
    required this.id,
    required this.name,
    required this.image,
    this.isFeatured = false,
    this.productsCount,
    this.createdAt,
    this.updatedAt,
    this.brandCategories,
  });

  static BrandModel empty() {
    return BrandModel(
      id: '',
      name: '',
      image: '',
    );
  }

  String get formattedDate => TFormatter.formatDate(createdAt);

  String get formattedUpdatedAt => TFormatter.formatDate(updatedAt);

  toJson() {
    return {
      'Id': id,
      'Name': name,
      'Image': image,
      'IsFeatured': isFeatured,
      'ProductsCount': productsCount,
      'CreatedAt': createdAt,
      'UpdatedAt': updatedAt,
    };
  }

  factory BrandModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() == null) return BrandModel.empty();

    return BrandModel(
      id: document.id,
      name: document.data()!['Name'] ?? '',
      image: document.data()!['Image'] ?? '',
      isFeatured: document.data()!['IsFeatured'] ?? false,
      productsCount: document.data()!['ProductsCount'] ?? '',
      createdAt: document.data()!.containsKey('createdAt') &&
              document.data()!['createdAt'] != null
          ? (document.data()!['createdAt'] as Timestamp).toDate()
          : null,
      updatedAt: document.data()!.containsKey('updatedAt') &&
              document.data()!['updatedAt'] != null
          ? (document.data()!['updatedAt'] as Timestamp).toDate()
          : null,
    );
  }

  factory BrandModel.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) return BrandModel.empty();
    return BrandModel(
      id: json['Id'] ?? '',
      name: json['Name'] ?? '',
      image: json['Image'] ?? '',
      isFeatured: json['IsFeatured'] ?? false,
      productsCount: int.parse((json['ProductsCount'] ?? 0).toString()),
      createdAt:
          json.containsKey('CreatedAt') ? json['CreatedAt']?.toDate() : null,
      updatedAt:
          json.containsKey('UpdatedAt') ? json['UpdatedAt']?.toDate() : null,
    );
  }
}
