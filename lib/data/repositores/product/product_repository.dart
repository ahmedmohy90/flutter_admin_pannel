import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../features/shop/models/product_category_model.dart';
import '../../../features/shop/models/product_model.dart';
import '../../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  // create product

  Future<String> createProduct(ProductModel newProductRecord) async {
    try {
      final data =
          await _db.collection('Products').add(newProductRecord.toJson());
      return data.id;
    } on FirebaseException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, Try again later';
    }
  }

  // create new product category

  Future<String> createProductCategory(
      ProductCategoryModel newProductCategoryRecord) async {
    try {
      final data = await _db
          .collection('ProductCategory')
          .add(newProductCategoryRecord.toJson());
      return data.id;
    } on FirebaseException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, Try again later';
    }
  }

  // update product
  Future<void> updateProduct(ProductModel product) async {
    try {
      await _db.collection('Products').doc(product.id).update(product.toJson());
    } on FirebaseException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, Try again later';
    }
  }

// delete product
  Future<void> deleteProduct(String productId) async {
    try {
      await _db.runTransaction((transaction) async {
        final productRef = _db.collection('Products').doc(productId);
        final productSnapshot = await transaction.get(productRef);
        if (!productSnapshot.exists) {
          throw Exception('Product not found');
        }
        final productCategorySnapshot = await _db
            .collection('ProductCategory')
            .where('productId', isEqualTo: productId)
            .get();
        final productCategories = productCategorySnapshot.docs
            .map((doc) => ProductCategoryModel.fromSnapshot(doc))
            .toList();
        if (productCategories.isNotEmpty) {
          for (final productCategory in productCategories) {
            transaction.delete(
                _db.collection('ProductCategory').doc(productCategory.id));
          }
        }
        transaction.delete(productRef);
      });
    } on FirebaseException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, Try again later';
    }
  }

  Future<List<ProductModel>> getAllProducts() async {
    try {
      final querySnapshot = await _db.collection('Products').get();
      final result =
          querySnapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
      return result;
    } on FirebaseException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, Try again later';
    }
  }


  Future<List<ProductCategoryModel>> getAllProductCategories() async {
    try {
      final querySnapshot = await _db.collection('ProductCategory').get();
      final result = querySnapshot.docs
          .map((e) => ProductCategoryModel.fromSnapshot(e))
          .toList();
      return result;
    } on FirebaseException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, Try again later';
    }
  }

  Future<List<ProductCategoryModel>> getCategoriesOfSpacificProduct(
      String id) async {
    try {
      final productCategoryQuery = await _db
          .collection('ProductCategory')
          .where('productId', isEqualTo: id)
          .get();
      final productCategories = productCategoryQuery.docs
          .map((e) => ProductCategoryModel.fromSnapshot(e))
          .toList();
      return productCategories;
    } on FirebaseException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, Try again later';
    }
  }

  Future<void> removeProductCategory(
      String id, String existingcategoryId) async {
    try {
      final result = await _db
          .collection('ProductCategory')
          .where('productId', isEqualTo: id)
          .where('categoryId', isEqualTo: existingcategoryId)
          .get();
      for (var doc in result.docs) {
        await doc.reference.delete();
      }
    } on FirebaseException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, Try again later';
    }
  }
}
