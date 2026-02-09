import 'package:admin_pannel/common/widgets/images/t_circular_image.dart';
import 'package:admin_pannel/utils/constants/colors.dart';
import 'package:admin_pannel/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../routes/routes.dart';
import '../../../../utils/constants/sizes.dart';
import 'menu/menu_item.dart';

class TSidebar extends StatelessWidget {
  const TSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const BeveledRectangleBorder(),
      child: Container(
        decoration: const BoxDecoration(
          color: TColors.white,
          border: Border(right: BorderSide(color: TColors.grey, width: 1.0)),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const TCircularImage(
                width: 100,
                height: 100,
                image: TImages.darkAppLogo,
                backgroundColor: Colors.transparent,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              Padding(
                  padding: const EdgeInsets.all(TSizes.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'MENU',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .apply(letterSpacingDelta: 1.2),
                      ),
                      const TMenuItem(
                        route: TRoutes.dashboard,
                        icon: Iconsax.status,
                        iconName: 'Dashboard',
                      ),
                      const TMenuItem(
                        route: TRoutes.media,
                        icon: Iconsax.image,
                        iconName: 'Media',
                      ),

                      const TMenuItem(
                        route: TRoutes.categories,
                        icon: Iconsax.category_2,
                        iconName: 'Categories',
                      ),

                      const TMenuItem(
                        route: TRoutes.brands,
                        icon: Iconsax.dcube,
                        iconName: 'Brands',
                      ),

                      const TMenuItem(
                        route: TRoutes.banners,
                        icon: Iconsax.picture_frame,
                        iconName: 'Banners',
                      ),
                      const TMenuItem(
                        route: TRoutes.products,
                        icon: Iconsax.shopping_bag,
                        iconName: 'Products',
                      ),
                      const TMenuItem(
                        route: TRoutes.customers,
                        icon: Iconsax.shopping_bag,
                        iconName: 'Customers',
                      ),
                      const TMenuItem(
                        route: TRoutes.orders,
                        icon: Iconsax.box,
                        iconName: 'Orders',
                      ),
                      //  Other Menu Items

                      Text(
                        'OTHER',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .apply(letterSpacingDelta: 1.2),
                      ),
                      const TMenuItem(
                        route: 'profile',
                        icon: Iconsax.user,
                        iconName: 'Profile',
                      ),
                      const TMenuItem(
                        route: 'settings',
                        icon: Iconsax.setting_2,
                        iconName: 'Settings',
                      ),
                      const TMenuItem(
                        route: 'logout',
                        icon: Iconsax.logout,
                        iconName: 'Logout',
                      ),

                      // const TMenuItem(
                      //   route: TRoutes.secondScreen,
                      //   icon: Iconsax.image,
                      //   iconName: 'Media',
                      // ),
                      // const TMenuItem(
                      //   route: TRoutes.responsiveDesignScreen,
                      //   icon: Iconsax.picture_frame,
                      //   iconName: 'Banners',
                      // ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
