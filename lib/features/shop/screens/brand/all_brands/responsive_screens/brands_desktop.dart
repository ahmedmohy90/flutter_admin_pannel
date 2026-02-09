import 'package:admin_pannel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:admin_pannel/common/widgets/containers/rounded_container.dart';
import 'package:admin_pannel/features/shop/controllers/brand/brand_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/widgets/data_table/table_header.dart';
import '../../../../../../common/widgets/loaders/loader_animation.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../widgets/brand_table.dart';

class BrandsDesktopScreen extends StatelessWidget {
  const BrandsDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BrandController());
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // BreadCrumbs
            const TBreadcrumbsWithHeading(
                heading: 'Brands', breadcumbsItems: ['Brands']),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),
            // Table Body
            TRoundedContainer(
                child: Column(
              children: [
                TTableHeaderWidget(
                  buttonText: 'Create New Brand',
                  onPressed: () => Get.toNamed(TRoutes.createBrands),
                ),
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                Obx(() {
                  if (controller.isLoading.value) {
                    return const TLoaderAnimation();
                  }

                  return const BrandTableWidget();
                })
              ],
            )),

            // Header
            // Categories
          ],
        ),
      )),
    );
  }
}
