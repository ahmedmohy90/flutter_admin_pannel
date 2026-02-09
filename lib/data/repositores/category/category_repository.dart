import 'package:admin_pannel/features/shop/models/category_model.dart';
import 'package:admin_pannel/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../utils/exceptions/platform_exceptions.dart';

class CategoryRepository extends GetxController {
  static CategoryRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Future<List<CategoryModel>> fetchCategories() async {
    try {
      final querySnapshot = await _db.collection('Categories').get();
      return querySnapshot.docs
          .map((e) => CategoryModel.fromSnapshot(e))
          .toList();
    } on FirebaseException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, Try again later';
      
    }
  }

  Future<void> deleteCategory(categoryId) async{
    try {
      await _db.collection('Categories').doc(categoryId).delete();
    } on FirebaseException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, Try again later';
      
    }
  }

  Future<String>  createCategory(CategoryModel newCategoryRecord) async{
      try {
     final data =  await _db.collection('Categories').add(newCategoryRecord.toJson());
      return data.id;
    } on FirebaseException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, Try again later';
      
    }
  }

  Future<void> updateCategory(CategoryModel category) async{
     try {
    await _db.collection('Categories').doc(category.id).update(category.toJson());
    } on FirebaseException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, Try again later';
      
    }
  }
}
