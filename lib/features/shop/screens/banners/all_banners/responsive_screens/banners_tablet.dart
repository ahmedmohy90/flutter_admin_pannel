import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../common/widgets/data_table/table_header.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../widgets/banner_table.dart';

class BrandsTabletScreen extends StatelessWidget {
  const BrandsTabletScreen({super.key});


  @override
  Widget build(BuildContext context) {
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
            TRoundedContainer(
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
            )),

            // Header
            // Categories
          ],
        ),
      )),
    );
  }
}
