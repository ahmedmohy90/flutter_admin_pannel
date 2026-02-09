import 'package:admin_pannel/data/repositores/category/category_repository.dart';
import 'package:admin_pannel/features/media/controllers/media_controller.dart';
import 'package:admin_pannel/features/media/models/image_model.dart';
import 'package:admin_pannel/features/shop/controllers/category/category_controller.dart';
import 'package:admin_pannel/utils/helpers/network_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';
import '../../models/category_model.dart';

class CreateCategoryController extends GetxController {
  static CreateCategoryController get instance => Get.find();

  final selectedParent = CategoryModel.empty().obs;
  final loading = false.obs;
  RxString imageURL = ''.obs;
  final isFeatured = false.obs;
  final name = TextEditingController();
  final formkey = GlobalKey<FormState>();

  // Method to reset fields

  // pick thumbnail Image from Media

  // Register new Category

  Future<void> createCategory() async {
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
      final newCategoryRecord = CategoryModel(
        id: '',
        name: name.text.trim(),
        imageUrl: imageURL.value,
        isFeatured: isFeatured.value,
        createdAt: DateTime.now(),
        parentId: selectedParent.value.id,
      );

      newCategoryRecord.id =
          await CategoryRepository.instance.createCategory(newCategoryRecord);

      CategoryController.instance.addItemToList(newCategoryRecord);

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
    selectedParent(CategoryModel.empty());
    name.clear();
    isFeatured(false);
    loading(false);
    imageURL.value = '';
  }
}
