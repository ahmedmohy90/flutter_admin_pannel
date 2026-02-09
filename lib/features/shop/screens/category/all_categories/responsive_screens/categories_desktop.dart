import 'package:admin_pannel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:admin_pannel/common/widgets/containers/rounded_container.dart';
import 'package:admin_pannel/common/widgets/loaders/loader_animation.dart';
import 'package:admin_pannel/features/shop/controllers/category/category_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/widgets/data_table/table_header.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../widgets/category_table.dart';

class CategoriesDesktopScreen extends StatelessWidget {
  const CategoriesDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryController());
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // BreadCrumbs
            const TBreadcrumbsWithHeading(
                heading: 'Categories', breadcumbsItems: ['Categories']),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),
            // Table Body
            TRoundedContainer(
                child: Column(
              children: [
                TTableHeaderWidget(
                  buttonText: 'Create New Category',
                  onPressed: () => Get.toNamed(TRoutes.createCategory),
                  searchController: controller.searchTextController,
                  searchOnChange: (query) => controller.searchQuery(query),
                ),
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                Obx(() {
                  if (controller.isLoading.value) {
                    return const TLoaderAnimation();
                  }
                  return const CategoryTableWidget();
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
