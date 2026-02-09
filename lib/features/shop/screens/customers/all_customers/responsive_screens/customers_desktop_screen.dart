import 'package:admin_pannel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:admin_pannel/common/widgets/containers/rounded_container.dart';
import 'package:admin_pannel/features/shop/controllers/customer/customer_controller.dart';
import 'package:admin_pannel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/widgets/data_table/table_header.dart';
import '../../../../../../common/widgets/loaders/loader_animation.dart';
import '../tables/data_table.dart';

class CustomersDesktopScreen extends StatelessWidget {
  const CustomersDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CustomerController());
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TBreadcrumbsWithHeading(
                heading: 'Customers', breadcumbsItems: ['Customers']),
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
                Obx(() { 
                  if(controller.isLoading.value){
                    return const TLoaderAnimation();
                  }
                  return const  CustomersTable();})
              ]),
            )
          ],
        ),
      ),
    ));
  }
}
