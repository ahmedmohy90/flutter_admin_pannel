import 'package:admin_pannel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:admin_pannel/features/shop/controllers/customer/customer_controller.dart';
import 'package:admin_pannel/features/shop/screens/customers/customer_details/widgets/shipping_address.dart';
import 'package:admin_pannel/routes/routes.dart';
import 'package:admin_pannel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../authentication/models/user_model.dart';
import '../../../../controllers/customer/customer_detail_controller.dart';
import '../widgets/customer_info.dart';
import '../widgets/customer_orders.dart';

class CustomerDetailsDesktopScreen extends StatelessWidget {
  const CustomerDetailsDesktopScreen({super.key, required this.customer});

  final UserModel customer;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CustomerDetailController());

    controller.customer.value = customer;
    return  Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             TBreadcrumbsWithHeading(
                returnToPreviousScreen: true,
                heading: customer.fullName,
                breadcumbsItems: const [TRoutes.customers, 'Details']),
          const   SizedBox(
              height: TSizes.spaceBtwSections,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      CustomerInfo(
                        customer: customer,
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwSections,
                      ),
                      const ShippingAddress(),
                    ],
                  ),
                ),
                const SizedBox(
                  width: TSizes.spaceBtwSections,
                ),
                const Expanded(
                  flex: 2,
                  child: CustomerOrders(),
                )
              ],
            )
          ],
        ),
      ),
    ));
  }
}
