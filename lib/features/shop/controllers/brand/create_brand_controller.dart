import 'package:admin_pannel/data/repositores/brands/brand_repository.dart';
import 'package:admin_pannel/data/repositores/category/category_repository.dart';
import 'package:admin_pannel/features/media/controllers/media_controller.dart';
import 'package:admin_pannel/features/media/models/image_model.dart';
import 'package:admin_pannel/features/shop/controllers/brand/brand_controller.dart';
import 'package:admin_pannel/features/shop/controllers/category/category_controller.dart';
import 'package:admin_pannel/features/shop/models/brand_model.dart';
import 'package:admin_pannel/utils/helpers/network_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';
import '../../models/brand_category_model.dart';
import '../../models/category_model.dart';

class CreateBrandController extends GetxController {
  static CreateBrandController get instance => Get.find();

  //   final selectedParent = BrandModel.empty().obs;
  final loading = false.obs;
  RxString imageURL = ''.obs;
  final isFeatured = false.obs;
  final name = TextEditingController();
  final formkey = GlobalKey<FormState>();
  final List<CategoryModel> selectedCategoryList = <CategoryModel>[].obs; // <CategoryModel>

  void toggleSelection(CategoryModel category) {
    if (selectedCategoryList.contains(category)) {
      selectedCategoryList.remove(category);
    } else {
      selectedCategoryList.add(category);
    }
  }



  Future<void> createBrand() async {
    try {
      TFullScreenLoader.popUpCircular();
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }
      if (!formkey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();

        return;
      }
      final newBrandRecord = BrandModel(
        id: '',
        productsCount: 0,
        name: name.text.trim(),
        image: imageURL.value,
        isFeatured: isFeatured.value,
        createdAt: DateTime.now(),
       
      );

      newBrandRecord.id =
          await BrandRepository.instance.createBrand(newBrandRecord);

      if(selectedCategoryList.isNotEmpty){
        if(newBrandRecord.id.isEmpty) throw 'Error storing relational data, try again';
      
      // Loop selected brand categories
      for(var category in selectedCategoryList){
        final brandCategory = BrandCategoryModel(
          brandId: newBrandRecord.id,
          categoryId: category.id,
        );

        await BrandRepository.instance.createBrandCategory(brandCategory); 
      }
      newBrandRecord.brandCategories ??=[];
      newBrandRecord.brandCategories!.addAll(selectedCategoryList);
      } 
      // reset form
            BrandController.instance.addItemToList(newBrandRecord);

      resetFields();
      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(
          title: 'Congratulations', message: 'Category Created Successfully');
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    }
  }

  void pickImage() async {
    final controller = Get.put(MediaController());

    List<ImageModel>? selectedImages = await controller.selectImageFromMedia();

    // handle the selected images
    if (selectedImages != null && selectedImages.isNotEmpty) {
      // set the selected image to the main image or perform any other action
      ImageModel selectedImage = selectedImages.first;
      imageURL.value = selectedImage.url;
    }
  }

  void resetFields() {
    name.clear();
    isFeatured(false);
    loading(false);
    imageURL.value = '';
    selectedCategoryList.clear();
  }
}
