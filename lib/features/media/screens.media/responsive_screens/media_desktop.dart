import 'package:admin_pannel/features/media/screens.media/widgets/media_content.dart';
import 'package:admin_pannel/features/media/screens.media/widgets/media_uploader.dart';
import 'package:admin_pannel/routes/routes.dart';
import 'package:admin_pannel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../controllers/media_controller.dart';

class MediaDesktopScreen extends StatelessWidget {
  const MediaDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MediaController());
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(children: [
          // Header
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Breadcrumbs
              const TBreadcrumbsWithHeading(
                heading: 'Media',
                breadcumbsItems: [TRoutes.login, 'Media Screen'],
                returnToPreviousScreen: true,
              ),

              SizedBox(
                width: TSizes.buttonWidth * 1.5,
                child: ElevatedButton.icon(
                    onPressed: () => controller.showImagesUploaderSection
                        .value = !controller.showImagesUploaderSection.value,
                    label: const Text('Upload Images'),
                    icon: const Icon(Iconsax.cloud_add)),
              )
            ],
          ),
          const SizedBox(
            height: TSizes.spaceBtwSections,
          ),
          //  upload area
          const MediaUploader(),
          const SizedBox(
            height: TSizes.spaceBtwSections,
          ),
          // Media Grid
          MediaContent(
            allowSelection: false,
            allowMultipleSelection: false,
          )
        ]),
      ),
    ));
  }
}
