import 'package:admin_pannel/data/repositores/category/category_repository.dart';
import 'package:admin_pannel/features/media/controllers/media_controller.dart';
import 'package:admin_pannel/features/media/models/image_model.dart';
import 'package:admin_pannel/features/shop/controllers/banner/banner_controller.dart';
import 'package:admin_pannel/features/shop/controllers/category/category_controller.dart';
import 'package:admin_pannel/routes/app_screens.dart';
import 'package:admin_pannel/utils/helpers/network_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/repositores/banner/banner_repository.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';
import '../../models/banner_model.dart';

class CreateBannerController extends GetxController {
  static CreateBannerController get instance => Get.find();

  final loading = false.obs;
  final imageURL = ''.obs;
  RxString targetScreen = AppScreens.allAppScreenItems[0].obs;
  final isActive = false.obs;
  final formKey = GlobalKey<FormState>();

  // Method to reset fields

  // pick thumbnail Image from Media

  // Register new Category



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

  Future<void> createBanner() async {
    try {
      TFullScreenLoader.popUpCircular();
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }
      if (!formKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();

        return;
      }
      final newRecord = BannerModel(
        id: '',
        imageUrl: imageURL.value,
        targetScreen: targetScreen.value,
        active: isActive.value,
      );

      newRecord.id =
          await BannerRepository.instance.createBanner(newRecord);

      BannerController.instance.addItemToList(newRecord);
      // reset form

      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(
          title: 'Congratulations', message: 'New Banner has been Created Successfully');
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    }
  }


  
}
