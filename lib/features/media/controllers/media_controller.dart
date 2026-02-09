import 'dart:io';
import 'dart:typed_data';

import 'package:admin_pannel/features/media/screens.media/widgets/media_content.dart';
import 'package:admin_pannel/features/media/screens.media/widgets/media_uploader.dart';
import 'package:admin_pannel/utils/constants/colors.dart';
import 'package:admin_pannel/utils/constants/enums.dart';
import 'package:admin_pannel/utils/constants/image_strings.dart';
import 'package:admin_pannel/utils/constants/text_strings.dart';
import 'package:admin_pannel/utils/popups/full_screen_loader.dart';
import 'package:admin_pannel/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart';
import '../../../common/widgets/loaders/circular_loader.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/popups/dialogs.dart';
import '../models/image_model.dart';

import 'package:universal_html/html.dart' as html;

import '../../../data/repositores/media/media_repository.dart';

class MediaController extends GetxController {
  static MediaController get instance => Get.find();
  Rx<bool> loading = false.obs;

  final int initialLoadCount = 20;
  final int loadMoreCount = 25;
  late DropzoneViewController dropzoneViewController;
  final Rx<bool> showImagesUploaderSection = false.obs;
  final Rx<MediaCategory> selectedPath = MediaCategory.folders.obs;

  final RxList<ImageModel> selectedImagesToUpload = <ImageModel>[].obs;

  final RxList<ImageModel> allImages = <ImageModel>[].obs;
  final RxList<ImageModel> allBannerImages = <ImageModel>[].obs;
  final RxList<ImageModel> allProductImages = <ImageModel>[].obs;
  final RxList<ImageModel> allBrandImages = <ImageModel>[].obs;
  final RxList<ImageModel> allCategoryImages = <ImageModel>[].obs;
  final RxList<ImageModel> allUserImages = <ImageModel>[].obs;

  final MediaRepository mediaRepository = MediaRepository();

  void getMediaImages() async {
    try {
      loading.value = true;
      RxList<ImageModel> targetList = <ImageModel>[].obs;
      if (selectedPath.value == MediaCategory.banners &&
          allBannerImages.isEmpty) {
        targetList = allBannerImages;
      } else if (selectedPath.value == MediaCategory.products &&
          allProductImages.isEmpty) {
        targetList = allProductImages;
      } else if (selectedPath.value == MediaCategory.brands &&
          allBrandImages.isEmpty) {
        targetList = allBrandImages;
      } else if (selectedPath.value == MediaCategory.categories &&
          allCategoryImages.isEmpty) {
        targetList = allCategoryImages;
      } else if (selectedPath.value == MediaCategory.users &&
          allUserImages.isEmpty) {
        targetList = allUserImages;
      }
      final images = await mediaRepository.fetchImagesFromDatabase(
          selectedPath.value, initialLoadCount);
      targetList.assignAll(images);
      loading.value = false;
    } catch (e) {
      loading.value = false;
      TLoaders.errorSnackBar(
          title: 'Oh Snap',
          message:
              'unable to fetch media images, something went wrong, please try again');
    }
  }

  void getMoreMediaImages() async {
    try {
      loading.value = true;
      RxList<ImageModel> targetList = <ImageModel>[].obs;
      if (selectedPath.value == MediaCategory.banners &&
          allBannerImages.isEmpty) {
        targetList = allBannerImages;
      } else if (selectedPath.value == MediaCategory.products &&
          allProductImages.isEmpty) {
        targetList = allProductImages;
      } else if (selectedPath.value == MediaCategory.brands &&
          allBrandImages.isEmpty) {
        targetList = allBrandImages;
      } else if (selectedPath.value == MediaCategory.categories &&
          allCategoryImages.isEmpty) {
        targetList = allCategoryImages;
      } else if (selectedPath.value == MediaCategory.users &&
          allUserImages.isEmpty) {
        targetList = allUserImages;
      }
      final images = await mediaRepository.loadMoreImagesFromDatabase(
          selectedPath.value,
          initialLoadCount,
          targetList.last.createdAt ?? DateTime.now());
      targetList.assignAll(images);
      loading.value = false;
    } catch (e) {
      loading.value = false;
      TLoaders.errorSnackBar(
          title: 'Oh Snap',
          message:
              'unable to fetch media images, something went wrong, please try again');
    }
  }

  Future<void> selectLocalImage() async {
    final files = await dropzoneViewController.pickFiles(
      multiple: true,
      mime: ['image/png', 'image/jpeg', 'image/jpg'],
    );
    if (files.isNotEmpty) {
      for (var file in files) {
        final bytes = await dropzoneViewController.getFileData(file);
        final image = ImageModel(
            filename: file.name,
            url: '',
            file: file,
            folder: '',
            localImageToDisplay: Uint8List.fromList(bytes));

        selectedImagesToUpload.add(image);
      }
    }
  }

  void uploadImagesConfirmation() {
    if (selectedPath.value == MediaCategory.folders) {
      TLoaders.warningSnackBar(
          title: 'Select Folder',
          message: 'Please select a folder to upload images');
      return;
    }
    TDialogs.defaultDialog(
      context: Get.context!,
      title: 'Upload Images',
      content:
          'Are you sure you want to upload these images in ${selectedPath.value.name.toUpperCase()} folder?',
      confirmText: 'Upload',
      onConfirm: () async => await uploadImages(),
    );
  }

  Future<void> uploadImages() async {
    try {
      Get.back();

      uploadImagesLoader();

      MediaCategory selectedCategory = selectedPath.value;

      // Get the corresponding List to update
      RxList<ImageModel> targetList;

      switch (selectedCategory) {
        case MediaCategory.banners:
          targetList = allBannerImages;
          break;
        case MediaCategory.products:
          targetList = allProductImages;
          break;
        case MediaCategory.brands:
          targetList = allBrandImages;
          break;
        case MediaCategory.categories:
          targetList = allCategoryImages;
          break;
        case MediaCategory.users:
          targetList = allUserImages;
          break;

        default:
          return;
      }
      // upload and add images to the target list
      // using a reverse loop to avoid 'concurrent modificaation during iteration error'

      for (int i = selectedImagesToUpload.length - 1; i >= 0; i--) {
        var selectedImage = selectedImagesToUpload[i];
        final image = selectedImage.file;

        // upload image to storage and get download url
        final ImageModel uploadedImage =
            await mediaRepository.uploadImageFileStorage(
          bytes: selectedImage.localImageToDisplay!,
          path: getSelectedPath(),
          imageName: selectedImage.filename,
        );

        uploadedImage.mediaCategory = selectedCategory.name;
        final id =
            await mediaRepository.uploadImageFileInDatabase(uploadedImage);
        uploadedImage.id = id;
        targetList.add(uploadedImage);
        selectedImagesToUpload.removeAt(i);
      }

      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(
          title: 'Images Uploaded',
          message: 'Images have been uploaded successfully');
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.warningSnackBar(
          title: 'Error Uploading Images', message: 'something went wrong');
    }
  }

  void uploadImagesLoader() {
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (context) => PopScope(
        canPop: false,
        child: AlertDialog(
          title: const Text('Uploading Images'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                TImages.uploadingImageIllustration,
                height: 300,
                width: 300,
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              const Text('Sit Tight, your images are uploading...'),
            ],
          ),
        ),
      ),
    );
  }

  String getSelectedPath() {
    String path = '';
    switch (selectedPath.value) {
      case MediaCategory.banners:
        path = TTexts.bannersStoragePath;
        break;
      case MediaCategory.products:
        path = TTexts.productsStoragePath;
        break;
      case MediaCategory.brands:
        path = TTexts.brandsStoragePath;
        break;
      case MediaCategory.categories:
        path = TTexts.categoriesStoragePath;
        break;
      case MediaCategory.users:
        path = TTexts.usersStoragePath;
        break;
      default:
        path = 'Others';
    }
    return path;
  }

  void removeCloudImageConfirmation(ImageModel image) {
    TDialogs.defaultDialog(
        context: Get.context!,
        // title: 'Delete Image',
        content: 'Are you sure you want to delete this image?',
        confirmText: 'Delete',
        onConfirm: () async {
          Get.back();
          removeCloudImage(image);
        });
  }

  void removeCloudImage(ImageModel image) async {
    try {
      Get.back();
      Get.defaultDialog(
          title: '',
          barrierDismissible: false,
          backgroundColor: Colors.transparent,
          content: const PopScope(
              canPop: false,
              child: SizedBox(
                height: 150,
                width: 150,
                child: TCircularLoader(),
              )));

      await mediaRepository.deleteFileFromStorage(image);

      RxList targetList;
      switch (selectedPath.value) {
        case MediaCategory.banners:
          targetList = allBannerImages;
          break;
        case MediaCategory.products:
          targetList = allProductImages;
          break;
        case MediaCategory.brands:
          targetList = allBrandImages;
          break;
        case MediaCategory.categories:
          targetList = allCategoryImages;
          break;
        case MediaCategory.users:
          targetList = allUserImages;
          break;

        default:
          return;
      }
      targetList.removeWhere((element) => element.id == image.id);
      update();
      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(
          title: 'Image Deleted',
          message: 'Image has been deleted successfully');
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  Future<List<ImageModel>> selectImageFromMedia(
      {List<String>? selectedUrls,
      bool allowSelection = true,
      bool allowMultipleSelection = false}) async {
    showImagesUploaderSection.value = true;
    List<ImageModel>? selectedImages = await Get.bottomSheet<List<ImageModel>>(
      isScrollControlled: true,
      backgroundColor: TColors.primaryBackground,
      FractionallySizedBox(
        heightFactor: 1,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            const MediaUploader(),
            MediaContent(
                allowSelection: allowSelection,
                allowMultipleSelection: allowMultipleSelection,
                alreadySelectedUrls: selectedUrls ?? [])
          ]),
        ),
      ),
    );
    return selectedImages ?? [];
  }
}
