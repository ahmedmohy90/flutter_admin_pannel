import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../common/widgets/data_table/table_header.dart';
import '../../../../../../common/widgets/loaders/loader_animation.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../controllers/product/products_controller.dart';
import '../widgets/product_table.dart';

class ProductsTabletScreen extends StatelessWidget {
  const ProductsTabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductsController());
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // BreadCrumbs
            const TBreadcrumbsWithHeading(
                heading: 'Products', breadcumbsItems: ['Products']),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),
            // Table Body
            Obx(() {
              if (controller.isLoading.value) {
                return const TLoaderAnimation();
              }
              return TRoundedContainer(
                child: Column(
                  children: [
                    TTableHeaderWidget(
                      buttonText: 'Create Product',
                      searchOnChange: (query) => controller.searchQuery(query),
                      onPressed: () => Get.toNamed(TRoutes.createProduct),
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),
                    const ProductTableWidget()
                  ],
                ),
              );
            }),

            // Header
            // Categories
          ],
        ),
      )),
    );
  }
}
