import 'package:flutter/material.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../models/order_model.dart';

class OrderDetailsTabletScreen extends StatelessWidget {
  const OrderDetailsTabletScreen({super.key, required this.order});
  final OrderModel order;
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TBreadcrumbsWithHeading(
                heading: 'Orders', breadcumbsItems: ['Orders']),
            SizedBox(
              height: TSizes.spaceBtwSections,
            ),
          ],
        ),
      ),
    ));
  }
}
