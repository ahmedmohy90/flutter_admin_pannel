import 'package:admin_pannel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:admin_pannel/common/widgets/containers/rounded_container.dart';
import 'package:admin_pannel/common/widgets/loaders/loader_animation.dart';
import 'package:admin_pannel/data/repositores/product/product_repository.dart';
import 'package:admin_pannel/features/shop/controllers/product/products_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/widgets/data_table/table_header.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../widgets/product_table.dart';

class ProductsDesktopScreen extends StatelessWidget {
  const ProductsDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProductRepository());
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
