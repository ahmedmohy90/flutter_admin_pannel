import 'package:admin_pannel/common/widgets/containers/rounded_container.dart';
import 'package:admin_pannel/common/widgets/images/image_uploader.dart';
import 'package:admin_pannel/utils/constants/enums.dart';
import 'package:admin_pannel/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../utils/constants/sizes.dart';

class ImageAndMeta extends StatelessWidget {
  const ImageAndMeta({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      padding: const EdgeInsets.symmetric(
        horizontal: TSizes.md,
        vertical: TSizes.lg,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// User Image

          /// Name & Email
          Column(
            children: [
              const TImageUploader(
                right: 10,
                bottom: 20,
                left: null,
                imageType: ImageType.asset,
                image: TImages.user,
                width: 200,
                height: 200,
                circular: true,
                icon: Iconsax.camera,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              Text(
                'Ahmed Mohy',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              Text(
                'ahmed.mohy@gmail.com',
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
            ],
          ),
        ],
      ),
    );
  }
}
