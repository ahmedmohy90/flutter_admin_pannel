import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../utils/formatters/formatter.dart';

class CategoryModel {
  String id;
  String name;
  String imageUrl;
  String parentId;
  bool isFeatured;
  DateTime? createdAt;
  DateTime? updatedAt;

  CategoryModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.parentId = '',
    this.isFeatured = false,
    this.createdAt,
    this.updatedAt,
  });

  String get formattedDate => TFormatter.formatDate(createdAt);

  String get formattedUpdatedAt => TFormatter.formatDate(updatedAt);
  static CategoryModel empty() {
    return CategoryModel(
      id: '',
      name: '',
      imageUrl: '',
      isFeatured: false,
    );
  }

  toJson() {
    return {
      'name': name,
      'imageUrl': imageUrl,
      'parentId': parentId,
      'isFeatured': isFeatured,
      'createdAt': createdAt,
      'updatedAt': updatedAt = DateTime.now(),
    };
  }

  factory CategoryModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> documet) {
    if (documet.data() != null) {
      final snapshot = documet.data()!;

      return CategoryModel(
        id: documet.id,
        name: snapshot['name'] ?? '',
        imageUrl: snapshot['imageUrl'] ?? '',
        parentId: snapshot['parentId'] ?? '',
        isFeatured: snapshot['isFeatured'] ?? false,
        createdAt:
            snapshot.containsKey('createdAt') && snapshot['createdAt'] != null
                ? (snapshot['createdAt'] as Timestamp).toDate()
                : null,
        updatedAt:
            snapshot.containsKey('updatedAt') && snapshot['updatedAt'] != null
                ? (snapshot['updatedAt'] as Timestamp).toDate()
                : null,
      );
    } else {
      return CategoryModel.empty();
    }
  }
}
