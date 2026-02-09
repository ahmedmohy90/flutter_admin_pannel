import 'package:admin_pannel/features/media/models/image_model.dart';
import 'package:admin_pannel/features/shop/models/product_variation_model.dart';
import 'package:get/get.dart';

import '../../../media/controllers/media_controller.dart';

class ProductImagesController extends GetxController {
  static ProductImagesController get instance => Get.find();

  final Rx<String?> selectedThumbnailImageUrl = Rx<String?>(null);
  final RxList<String> additionalProductImagesUrls = <String>[].obs;

  // pick Thumbnail
  void selectThumbnailImage() async {
    final controller = Get.put(MediaController());
    List<ImageModel>? selectedImages = await controller.selectImageFromMedia();

    // handle the selected images
    if (selectedImages != null && selectedImages.isNotEmpty) {
      // set the selected image to the main image or perform any other action
      ImageModel mainImage = selectedImages.first;
      selectedThumbnailImageUrl.value = mainImage.url;
    }
  }

  void selectVariationImage(ProductVariationModel variation) async {
    final controller = Get.put(MediaController());
    List<ImageModel>? selectedImages = await controller.selectImageFromMedia();

    if(selectedImages != null && selectedImages.isNotEmpty){
      ImageModel selectedImage = selectedImages.first;
      variation.image.value = selectedImage.url;
    }
  
  }
  // pick multiple product images

  void selectMultipleProductImages() async {
    final controller = Get.put(MediaController());
    final selectedImages = await controller.selectImageFromMedia(
      allowMultipleSelection: true,
      selectedUrls: additionalProductImagesUrls,
    );

    // handle the selected images
    if (selectedImages != null && selectedImages.isNotEmpty) {
      additionalProductImagesUrls
          .assignAll(selectedImages.map((image) => image.url));
    }
  }

  // function to remoeve image
  void removeImage(int imageindexUrl) {
    additionalProductImagesUrls.removeAt(imageindexUrl) ;
  }
}
