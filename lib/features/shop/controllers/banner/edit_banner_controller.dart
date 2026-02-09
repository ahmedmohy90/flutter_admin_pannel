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

class EditBannerController extends GetxController {
  static EditBannerController get instance => Get.find();
  final repository = BannerRepository.instance;
  final targetScreen  = ''.obs;
  final loading = false.obs;
  final imageURL = ''.obs;
  final isActive = false.obs;
  final formKey = GlobalKey<FormState>();

  // Method to reset fields

  // pick thumbnail Image from Media

  // Register new Category

  void init(BannerModel banner) {
    targetScreen.value = banner.targetScreen;
    isActive.value = banner.active;
    imageURL.value = banner.imageUrl;
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

  Future<void> updateBanner(BannerModel banner) async {
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
      if(banner.imageUrl != imageURL.value || banner.targetScreen != targetScreen.value || banner.active != isActive.value){
        banner.imageUrl = imageURL.value;
        banner.targetScreen = targetScreen.value;
        banner.active = isActive.value;
        await repository.updateBanner(banner);{
        
      }
      
       BannerController.instance.updateItemFromLists(banner);
      // reset form

      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(
          title: 'Congratulations', message: ' Banner has been updated Successfully');
    }
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    }
  

  }
  
}
