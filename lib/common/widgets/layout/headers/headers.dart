import 'package:admin_pannel/common/widgets/images/t_rounded_image.dart';
import 'package:admin_pannel/common/widgets/shimmers/shimmer.dart';
import 'package:admin_pannel/features/authentication/controllers/user_controller.dart';
import 'package:admin_pannel/utils/constants/enums.dart';
import 'package:admin_pannel/utils/constants/image_strings.dart';
import 'package:admin_pannel/utils/constants/sizes.dart';
import 'package:admin_pannel/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';

class THeader extends StatelessWidget implements PreferredSizeWidget {
  const THeader({super.key, this.scaffoldKey});

  final GlobalKey<ScaffoldState>? scaffoldKey;

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Container(
      decoration: const BoxDecoration(
        color: TColors.white,
        border: Border(
          bottom: BorderSide(width: 1.0, color: TColors.grey),
        ),
      ),
      padding: const EdgeInsets.symmetric(
          horizontal: TSizes.md, vertical: TSizes.sm),
      child: AppBar(
        leading: !TDeviceUtils.isDesktopScreen(context)
            ? IconButton(
                onPressed: () => scaffoldKey!.currentState?.openDrawer(),
                icon: const Icon(Iconsax.menu))
            : null,
        title: TDeviceUtils.isDesktopScreen(context)
            ? SizedBox(
                width: 400,
                child: TextFormField(
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.search_normal),
                      hintText: 'Search...'),
                ),
              )
            : null,

        // actions
        actions: [
          if (!TDeviceUtils.isDesktopScreen(context))
            IconButton(
                onPressed: () {}, icon: const Icon(Iconsax.search_normal)),
          IconButton(
            onPressed: () {},
            icon: const Icon(Iconsax.notification),
          ),
          const SizedBox(
            width: TSizes.spaceBtwItems / 2,
          ),
          Row(children: [
            TRoundedImage(
                imageType: controller.user.value.profilePicture == null
                    ? ImageType.asset
                    : controller.user.value.profilePicture!.isNotEmpty
                        ? ImageType.network
                        : ImageType.asset,
                image: controller.user.value.profilePicture == null
                    ? TImages.user
                    : controller.user.value.profilePicture!.isNotEmpty
                        ? controller.user.value.profilePicture
                        : TImages.user),
            const SizedBox(
              width: TSizes.sm,
            ),
            if (!TDeviceUtils.isMobileScreen(context))
              Obx(
                () => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    controller.loading.value
                        ? const TShimmerEffect(width: 50, height: 13)
                        : Text(
                            controller.user.value.fullName,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                    controller.loading.value
                        ? const TShimmerEffect(width: 50, height: 13)
                        : Text(
                            controller.user.value.email!,
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                  ],
                ),
              )
          ])
        ],
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(TDeviceUtils.getAppBarHeight() + 15);
}
