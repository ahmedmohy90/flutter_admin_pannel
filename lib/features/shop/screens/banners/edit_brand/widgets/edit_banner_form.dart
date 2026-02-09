import 'package:admin_pannel/common/widgets/containers/rounded_container.dart';
import 'package:admin_pannel/common/widgets/images/image_uploader.dart';
import 'package:admin_pannel/features/shop/models/banner_model.dart';
import 'package:admin_pannel/utils/constants/image_strings.dart';
import 'package:admin_pannel/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../common/widgets/chips/rounded_choice_chips.dart';
import '../../../../../../common/widgets/images/t_rounded_image.dart';
import '../../../../../../routes/app_screens.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/enums.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../controllers/banner/edit_banner_controller.dart';

class EditBannerForm extends StatelessWidget {
  const EditBannerForm({super.key, required this.banner});

  final BannerModel banner;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditBannerController());
    controller.init(banner);
    return TRoundedContainer(
      width: 500,
      padding: EdgeInsets.all(TSizes.defaultSpace),
      child: Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: TSizes.sm,
            ),
            Text('Update Banner',
                style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),
            Column(
              children: [
                Obx(
                  () => TRoundedImage(
                    imageType: controller.imageURL.value.isNotEmpty
                        ? ImageType.network
                        : ImageType.asset,
                    width: 400,
                    height: 200,
                    image: controller.imageURL.value.isNotEmpty
                        ? controller.imageURL.value
                        : TImages.defaultImage,
                    backgroundColor: TColors.primaryBackground,
                  ),
                ),
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                TextButton(
                  onPressed: () => controller.pickImage(),
                  child: const Text('Select Image'),
                ),
              ],
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),
            Text(
              'Make your Banner Active or Inactive',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Obx(
              () => CheckboxMenuButton(
                value: controller.isActive.value,
                onChanged: (value) =>
                    controller.isActive.value = value ?? false,
                child: const Text('Active'),
              ),
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),
            Obx(() {
              return DropdownButton(
                value: controller.targetScreen.value,
                items: AppScreens.allAppScreenItems
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (String? value) =>
                    controller.targetScreen.value = value!,
              );
            }),
            const SizedBox(
              height: TSizes.spaceBtwInputFields * 2,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.updateBanner(banner),
                child: const Text('Update'),
              ),
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields * 2,
            ),
          ],
        ),
      ),
    );
  }
}
