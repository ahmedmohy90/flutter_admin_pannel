import 'package:admin_pannel/features/shop/controllers/order/order_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../common/widgets/data_table/table_header.dart';
import '../../../../../../common/widgets/loaders/loader_animation.dart';
import '../../../../../../data/repositores/order/order_repository.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../tables/data_table.dart';

class OrdersDesktopScreen extends StatelessWidget {
  const OrdersDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(OrderRepository());
    final controller = Get.put(OrderController());
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TBreadcrumbsWithHeading(
                heading: 'Orders', breadcumbsItems: ['Orders']),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),
            TRoundedContainer(
              child: Column(children: [
                TTableHeaderWidget(
                  showLeftWidget: false,
                  searchController: controller.searchTextController,
                  searchOnChange: (query) => controller.searchQuery(query),
                ),
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                Obx(
                  () {
                    if (controller.isLoading.value) {
                      return const TLoaderAnimation();
                    }
                    return const OrderTable();
                  },
                )
              ]),
            )
          ],
        ),
      ),
    ));
  }
}
