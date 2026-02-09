import 'package:admin_pannel/common/widgets/containers/rounded_container.dart';
import 'package:admin_pannel/common/widgets/images/t_rounded_image.dart';
import 'package:admin_pannel/features/shop/controllers/product/product_images_controller.dart';
import 'package:admin_pannel/utils/constants/colors.dart';
import 'package:admin_pannel/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../utils/constants/enums.dart';
import '../../../../../../utils/constants/sizes.dart';

class ProductThumbnailImage extends StatelessWidget {
  const ProductThumbnailImage({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductImagesController controller =
        Get.put(ProductImagesController());
    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Product Thumbnail',
              style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),
          Obx(
            () => TRoundedContainer(
              height: 300,
              backgroundColor: TColors.primaryBackground,
              child: Center(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            child: TRoundedImage(
                          width: 220,
                          height: 220,
                          imageType:
                              controller.selectedThumbnailImageUrl.value == null
                                  ? ImageType.asset
                                  : ImageType.network,
                          image: controller.selectedThumbnailImageUrl.value ??
                              TImages.defaultSingleImageIcon,
                        )),
                      ],
                    ),
                    SizedBox(
                      width: 200,
                      child: OutlinedButton(
                          onPressed: () => controller.selectThumbnailImage(),
                          child: const Text('Add Thumbnail')),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
