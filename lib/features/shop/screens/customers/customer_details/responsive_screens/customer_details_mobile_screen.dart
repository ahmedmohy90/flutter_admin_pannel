import 'package:admin_pannel/features/shop/screens/customers/customer_details/widgets/shipping_address.dart';
import 'package:flutter/material.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../authentication/models/user_model.dart';
import '../widgets/customer_info.dart';
import '../widgets/customer_orders.dart';

class CustomerDetailsMobileScreen extends StatelessWidget {
  const CustomerDetailsMobileScreen({super.key, required this.customer});

  final UserModel customer;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TBreadcrumbsWithHeading(
                returnToPreviousScreen: true,
                heading: 'Ahmed Mohy',
                breadcumbsItems: [TRoutes.customers, 'Details']),
            const SizedBox(
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
