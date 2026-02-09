import 'package:admin_pannel/data/repositores/brands/brand_repository.dart';
import 'package:admin_pannel/features/shop/controllers/brand/brand_controller.dart';
import 'package:admin_pannel/features/shop/controllers/category/category_controller.dart';
import 'package:admin_pannel/features/shop/models/brand_model.dart';
import 'package:admin_pannel/features/shop/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/repositores/category/category_repository.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';
import '../../../media/controllers/media_controller.dart';
import '../../../media/models/image_model.dart';
import '../../models/brand_category_model.dart';

class EditBrandController extends GetxController {
  static EditBrandController get instance => Get.find();

  final loading = false.obs;
  RxString imageURL = ''.obs;
  final isFeatured = false.obs;
  final name = TextEditingController();
  final formkey = GlobalKey<FormState>();

  final repository = Get.put(BrandRepository());
  final List<CategoryModel> selectedCategories = <CategoryModel>[].obs;

  // init Data
  void init(BrandModel brand) {
    name.text = brand.name;
    isFeatured.value = brand.isFeatured;
    imageURL.value = brand.image;
    if (brand.brandCategories != null) {
      selectedCategories.addAll(brand.brandCategories ?? []);
    }
  }

  void toggleSelection(CategoryModel category) {
    if (selectedCategories.contains(category)) {
      selectedCategories.remove(category);
    } else {
      selectedCategories.add(category);
    }
  }
  // Method to reset fields

  // pick thumbnail Image from Media

  // Register new Category

  Future<void> updateBrand(BrandModel brand) async {
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
      // IS Data updated
      bool isBrandUpdated = false;
      if (brand.image != imageURL.value ||
          brand.name != name.text.trim() ||
          brand.isFeatured != isFeatured.value) {
        isBrandUpdated = true;
        // Map data
        brand.name = name.text.trim();
        brand.image = imageURL.value;
        brand.isFeatured = isFeatured.value;
        brand.updatedAt = DateTime.now();
        // call repo to update
        await repository.updateBrand(brand);
      }
      //  Update BrandCategory

      if (selectedCategories.isNotEmpty) await updateBrandCategories(brand);
      //  Update Products
      if (isBrandUpdated) {
        await updateBrandInProducts(brand);
      }
// update all data list
      BrandController.instance.updateItemFromLists(brand);
      update();

      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(
          title: 'Congratulations', message: 'Brand updated Successfully');
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    }
  }

  void resetFields() {
    name.clear();
    isFeatured(false);
    loading(false);
    imageURL.value = '';
    selectedCategories.clear();
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

  updateBrandCategories(BrandModel brand) async {
    final brandCategories =
        await repository.getCategoriesOfSpacificBrand(brand.id);

    final selectedCategoryIds =
        selectedCategories.map((category) => category.id).toList();

    final categoriesToRemove = brandCategories
        .where((brandCategory) =>
            !selectedCategoryIds.contains(brandCategory.categoryId))
        .toList();

    for (var categoryToRemove in categoriesToRemove) {
      await repository.deleteBrandCategory(categoryToRemove.id ?? '');
    }

    final newCategoriesToAdd = selectedCategories
        .where((category) => !brandCategories
            .any((brandCategory) => brandCategory.categoryId == category.id))
        .toList();
    for (var newCategory in newCategoriesToAdd) {
      var brandCategory = BrandCategoryModel(
        brandId: brand.id,
        categoryId: newCategory.id,
      );
      brandCategory.id = await repository.createBrandCategory(brandCategory);
    }
    brand.brandCategories!.assignAll(selectedCategories);
    BrandController.instance.updateItemFromLists(brand);
  }

  updateBrandInProducts(BrandModel brand) {}
}
