import 'dart:io';

import 'package:admin_pannel/features/media/models/image_model.dart';
import 'package:flutter/services.dart';
import 'package:universal_html/html.dart' as html;
import 'package:admin_pannel/common/widgets/containers/rounded_container.dart';
import 'package:admin_pannel/common/widgets/images/t_rounded_image.dart';
import 'package:admin_pannel/features/media/controllers/media_controller.dart';
import 'package:admin_pannel/features/media/screens.media/widgets/folder_dropdown.dart';
import 'package:admin_pannel/utils/constants/colors.dart';
import 'package:admin_pannel/utils/constants/enums.dart';
import 'package:admin_pannel/utils/constants/image_strings.dart';
import 'package:admin_pannel/utils/constants/sizes.dart';
import 'package:admin_pannel/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart';

class MediaUploader extends StatelessWidget {
  const MediaUploader({super.key, this.onChange});

  final void Function(MediaCategory?)? onChange;
  @override
  Widget build(BuildContext context) {
    final controller = MediaController.instance;
    return Obx(
      () => controller.showImagesUploaderSection.value
          ? Column(
              children: [
                // Drag and drop area
                TRoundedContainer(
                  height: 250,
                  showBorder: true,
                  borderColor: TColors.borderPrimary,
                  backgroundColor: TColors.primaryBackground,
                  padding: const EdgeInsets.all(TSizes.defaultSpace),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              DropzoneView(
                                mime: const [
                                  'image/png',
                                  'image/jpeg',
                                  'image/jpg',
                                ],
                                cursor: CursorType.Default,
                                operation: DragOperation.copy,
                                onLoaded: () => print('onLoaded'),
                                onError: (err) => print(err),
                                onHover: () => print('onHover'),
                                onLeave: () => print('onLeave'),
                                onCreated: (ctrl) =>
                                    controller.dropzoneViewController = ctrl,
                                onDropFile: (file) async {
                                  if (file is DropzoneFileInterface) {
                                    final bytes = await controller
                                        .dropzoneViewController
                                        .getFileData(file);
                                    final image = ImageModel(
                                        filename: file.name,
                                        url: '',
                                        file: file,
                                        folder: '',
                                        localImageToDisplay:
                                            Uint8List.fromList(bytes));

                                    controller.selectedImagesToUpload
                                        .add(image);
                                  } else if (file is String) {
                                    print('file is String');
                                  } else {
                                    print(
                                        'file is unknown with type ${file.runtimeType}');
                                  }
                                },
                                onDropInvalid: (ev) =>
                                    print('onDropInvalid$ev'),
                                onDropStrings: (ev) =>
                                    print('onDropMultiple$ev'),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset(TImages.defaultMultiImageIcon,
                                      height: 50, width: 50),
                                  SizedBox(
                                    height: TSizes.spaceBtwItems,
                                  ),
                                  const Text(
                                    'Drag and drop images here',
                                  ),
                                  const SizedBox(
                                    height: TSizes.spaceBtwItems,
                                  ),
                                  OutlinedButton(
                                      onPressed: () =>
                                          controller.selectLocalImage(),
                                      child: Text('select images'))
                                ],
                              )
                            ],
                          ),
                        ),
                      ]),
                ),
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),

                if (controller.selectedImagesToUpload.isNotEmpty)
                  // locally Selected images
                  TRoundedContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: [
                              Text(
                                'Selected Folder',
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                              const SizedBox(
                                width: TSizes.spaceBtwItems,
                              ),
                              MediaFolderDropDown(
                                onChange: (MediaCategory? newValue) {
                                  if (newValue != null) {
                                    controller.selectedPath.value = newValue;
                                  }
                                },
                              )
                            ]),
                            Row(
                              children: [
                                TextButton(
                                  onPressed: () =>
                                      controller.selectedImagesToUpload.clear(),
                                  child: const Text('Remove All'),
                                ),
                                const SizedBox(
                                  width: TSizes.spaceBtwItems,
                                ),
                                TDeviceUtils.isMobileScreen(context)
                                    ? const SizedBox.shrink()
                                    : SizedBox(
                                        width: TSizes.buttonWidth,
                                        child: ElevatedButton.icon(
                                          onPressed: () {
                                            controller
                                                .uploadImagesConfirmation();
                                          },
                                          label: const Text('Upload'),
                                        ),
                                      ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: TSizes.spaceBtwSections,
                        ),
                        Wrap(
                          alignment: WrapAlignment.start,
                          spacing: TSizes.spaceBtwItems / 2,
                          runSpacing: TSizes.spaceBtwItems / 2,
                          children: controller.selectedImagesToUpload
                              .where(
                                  (image) => image.localImageToDisplay != null)
                              .map((image) => TRoundedImage(
                                    imageType: ImageType.memory,
                                    width: 90,
                                    height: 90,
                                    padding: TSizes.sm,
                                    memoryImage: image.localImageToDisplay,
                                  ))
                              .toList(),
                        ),
                        const SizedBox(
                          height: TSizes.spaceBtwSections,
                        ),
                        TDeviceUtils.isMobileScreen(context)
                            ? SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                    onPressed: () {
                                      controller.uploadImagesConfirmation();
                                    },
                                    child: const Text('Upload')),
                              )
                            : const SizedBox.shrink()
                      ],
                    ),
                  )
              ],
            )
          : const SizedBox.shrink(),
    );
  }
}
