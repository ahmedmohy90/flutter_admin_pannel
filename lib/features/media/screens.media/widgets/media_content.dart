import 'package:admin_pannel/common/widgets/containers/rounded_container.dart';
import 'package:admin_pannel/common/widgets/loaders/animation_loader.dart';
import 'package:admin_pannel/common/widgets/loaders/loader_animation.dart';
import 'package:admin_pannel/features/media/controllers/media_controller.dart';
import 'package:admin_pannel/features/media/models/image_model.dart';
import 'package:admin_pannel/features/media/screens.media/widgets/folder_dropdown.dart';
import 'package:admin_pannel/utils/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/images/t_rounded_image.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/device/device_utility.dart';
import 'image_details_widget.dart';

class MediaContent extends StatelessWidget {
  MediaContent({
    super.key,
    required this.allowSelection,
    required this.allowMultipleSelection,
    this.alreadySelectedUrls,
    this.onImageSelected,
  });

  final bool allowSelection;
  final bool allowMultipleSelection;
  final List<String>? alreadySelectedUrls;
  final List<ImageModel> selectedImages = [];
  final Function(List<ImageModel> selectedImages)? onImageSelected;

  @override
  Widget build(BuildContext context) {
    bool loadedPrevoiusSelection = false;
    final controller = MediaController.instance;
    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                Text(
                  'Selected Folder',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(
                  width: TSizes.spaceBtwItems,
                ),
                MediaFolderDropDown(
                  onChange: (MediaCategory? newValue) {
                    if (newValue != null) {
                      controller.selectedPath.value = newValue;
                      controller.getMediaImages();
                    }
                  },
                )
              ]),

              // Row(
              //   children: [
              //     TextButton(
              //       onPressed: () {},
              //       child: const Text('Remove All'),
              //     ),
              //     const SizedBox(
              //       width: TSizes.spaceBtwItems,
              //     ),
              //     TDeviceUtils.isMobileScreen(context)
              //         ? const SizedBox.shrink()
              //         : SizedBox(
              //             width: TSizes.buttonWidth,
              //             child: ElevatedButton.icon(
              //               onPressed: () {},
              //               label: const Text('Upload'),
              //             ),
              //           ),
              //   ],
              // ),

              if (allowSelection) buildAddSelectionButton(),
            ],
          ),
          const SizedBox(
            height: TSizes.spaceBtwSections,
          ),
          Obx(
            () {
              List<ImageModel> images = _getSelectedFolderImages(controller);
              if (!loadedPrevoiusSelection) {
                if (alreadySelectedUrls != null &&
                    alreadySelectedUrls!.isNotEmpty) {
                  // convert alreadySelectedUrls to set for faster lookup
                  final selectedUrlsSet =
                      Set<String>.from(alreadySelectedUrls!);
                  for (var image in images) {
                    image.isSelected.value =
                        selectedUrlsSet.contains(image.url);
                    if (image.isSelected.value) {
                      selectedImages.add(image);
                    }
                  }
                } else {
                  //  if alreadySelectedUrls is null or empty, set isSelected to false for all images
                  for (var image in images) {
                    image.isSelected.value = false;
                  }
                }
                loadedPrevoiusSelection = true;
              }

              if (controller.loading.value && images.isEmpty) {
                return const TLoaderAnimation();
              }
              if (images.isEmpty) {
                return _buildEmptyAnimationWidget(context);
              }

              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    alignment: WrapAlignment.start,
                    spacing: TSizes.spaceBtwItems / 2,
                    runSpacing: TSizes.spaceBtwItems / 2,
                    children: images
                        .map((image) => GestureDetector(
                            onTap: () {
                              Get.dialog(ImagePopup(image: image));
                            },
                            child: SizedBox(
                              width: 140,
                              height: 180,
                              child: Column(
                                children: [
                                  allowSelection
                                      ? _buildListWithCheckbox(image)
                                      : _buildSimpleList(image),
                                  Expanded(
                                      child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: TSizes.sm),
                                    child: Text(
                                      image.filename,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ))
                                ],
                              ),
                            )))
                        .toList(),
                  ),
                  if (!controller.loading.value)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: TSizes.spaceBtwSections,
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: TSizes.buttonWidth,
                            child: ElevatedButton.icon(
                              onPressed: () => controller.getMoreMediaImages(),
                              label: const Text('Load More'),
                              icon: const Icon(Iconsax.arrow_down),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  List<ImageModel> _getSelectedFolderImages(MediaController controller) {
    List<ImageModel> images = [];
    if (controller.selectedPath.value == MediaCategory.banners) {
      images = controller.allBannerImages
          .where((image) => image.url.isNotEmpty)
          .toList();
    } else if (controller.selectedPath.value == MediaCategory.products) {
      images = controller.allProductImages
          .where((image) => image.url.isNotEmpty)
          .toList();
      ;
    } else if (controller.selectedPath.value == MediaCategory.brands) {
      images = controller.allBrandImages
          .where((image) => image.url.isNotEmpty)
          .toList();
      ;
    } else if (controller.selectedPath.value == MediaCategory.categories) {
      images = controller.allCategoryImages
          .where((image) => image.url.isNotEmpty)
          .toList();
      ;
    } else if (controller.selectedPath.value == MediaCategory.users) {
      images = controller.allUserImages
          .where((image) => image.url.isNotEmpty)
          .toList();
      ;
    }

    return images;
  }

  Widget _buildEmptyAnimationWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: TSizes.lg * 3),
      child: TAnimationLoaderWidget(
        width: 300,
        height: 300,
        text: 'select your desired folder',
        animation: TImages.packageAnimation,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }

  _buildSimpleList(ImageModel image) {
    return TRoundedImage(
      imageType: ImageType.network,
      width: 140,
      height: 140,
      image: image.url,
      padding: TSizes.sm,
      margin: TSizes.spaceBtwItems / 2,
      backgroundColor: TColors.primaryBackground,
    );
  }

  _buildListWithCheckbox(ImageModel image) {
    return Stack(
      children: [
        TRoundedImage(
          imageType: ImageType.network,
          width: 140,
          height: 140,
          image: image.url,
          padding: TSizes.sm,
          margin: TSizes.spaceBtwItems / 2,
          backgroundColor: TColors.primaryBackground,
        ),
        Positioned(
            top: TSizes.md,
            right: TSizes.md,
            child: Obx(() => Checkbox(
                  value: image.isSelected.value,
                  onChanged: (selected) {
                    if (selected != null) {
                      image.isSelected.value = selected;
                      if (selected) {
                        if (!allowMultipleSelection) {
                          for (var otherImage in selectedImages) {
                            otherImage.isSelected.value = false;
                          }
                        }
                        selectedImages.add(image);
                      } else {
                        selectedImages.remove(image);
                      }
                    }
                  },
                )))
      ],
    );
  }

  Widget buildAddSelectionButton() {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      SizedBox(
        width: 120,
        child: OutlinedButton.icon(
          onPressed: () => Get.back(),
          label: const Text('Close'),
          icon: const Icon(Iconsax.close_circle),
        ),
      ),
      const SizedBox(
        width: TSizes.spaceBtwItems,
      ),
      SizedBox(
        width: 120,
        child: ElevatedButton.icon(
          onPressed: () => Get.back(result: selectedImages),
          label: const Text('Add'),
          icon: const Icon(Iconsax.image),
        ),
      ),
    ]);
  }
}
