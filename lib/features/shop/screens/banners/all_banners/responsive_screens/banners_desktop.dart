import 'package:admin_pannel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:admin_pannel/common/widgets/containers/rounded_container.dart';
import 'package:admin_pannel/features/shop/controllers/banner/banner_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/widgets/data_table/table_header.dart';
import '../../../../../../common/widgets/loaders/loader_animation.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../widgets/banner_table.dart';

class BannersDesktopScreen extends StatelessWidget {
  const BannersDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BannerController());
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // BreadCrumbs
            const TBreadcrumbsWithHeading(
                heading: 'Banners', breadcumbsItems: ['Banners']),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),
            // Table Body
            Obx(() {
              if(controller.isLoading.value){
                return const TLoaderAnimation();
              }
           return TRoundedContainer(
                  child: Column(
                children: [
                  TTableHeaderWidget(
                    buttonText: 'Create New Banner',
                    onPressed: () => Get.toNamed(TRoutes.createBanner),
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  const BannerTableWidget()
                ],
              ),);
            }
            ),

            // Header
            // Categories
          ],
        ),
      )),
    );
  }
}
