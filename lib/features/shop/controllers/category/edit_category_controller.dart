import 'package:admin_pannel/features/shop/controllers/category/category_controller.dart';
import 'package:admin_pannel/features/shop/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/repositores/category/category_repository.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';
import '../../../media/controllers/media_controller.dart';
import '../../../media/models/image_model.dart';

class EditCategoryController extends GetxController {
  static EditCategoryController get instance => Get.find();

  final selectedParent = CategoryModel.empty().obs;
  final loading = false.obs;
  RxString imageURL = ''.obs;
  final isFeatured = false.obs;
  final name = TextEditingController();
  final formkey = GlobalKey<FormState>();

  // init Data
  void init(CategoryModel category) {
    name.text = category.name;
    isFeatured.value = category.isFeatured;
    imageURL.value = category.imageUrl;
    if (category.parentId.isNotEmpty) {
      selectedParent.value = CategoryController.instance.allItems
          .where((item) => item.id == category.parentId)
          .single;
    }
  }
  // Method to reset fields

  // pick thumbnail Image from Media

  // Register new Category

  Future<void> updateCategory(CategoryModel category) async {
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
      category.name = name.text.trim();
      category.imageUrl = imageURL.value;
      category.isFeatured = isFeatured.value;
      category.parentId = selectedParent.value.id;
      category.updatedAt = DateTime.now();

      await CategoryRepository.instance.updateCategory(category);

      CategoryController.instance.updateItemFromLists(category);

      // reset form

      resetFields();
      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(
          title: 'Congratulations', message: 'Category Created Successfully');
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    }
  }

  void resetFields() {
    selectedParent(CategoryModel.empty());
    name.clear();
    isFeatured(false);
    loading(false);
    imageURL.value = '';
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
}
