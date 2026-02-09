import 'package:admin_pannel/data/repositores/user/user_repository.dart';
import 'package:admin_pannel/features/shop/screens/order/order_details/widgets/order_info.dart';
import 'package:admin_pannel/features/shop/screens/order/order_details/widgets/order_items.dart';
import 'package:admin_pannel/features/shop/screens/order/order_details/widgets/order_transaction.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';

import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../models/order_model.dart';
import '../widgets/order_customer.dart';

class OrderDetailsDesktopScreen extends StatefulWidget {
  const OrderDetailsDesktopScreen({super.key, required this.order});
  final OrderModel order;

  @override
  State<OrderDetailsDesktopScreen> createState() =>
      _OrderDetailsDesktopScreenState();
}

class _OrderDetailsDesktopScreenState extends State<OrderDetailsDesktopScreen> {
  @override
  void initState() {
    Get.put(UserRepository());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TBreadcrumbsWithHeading(
                returnToPreviousScreen: true,
                heading: widget.order.id,
                breadcumbsItems: const [TRoutes.orders, 'Details']),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left side
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      OrderInfo(
                        order: widget.order,
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwSections,
                      ),
                      OrderItems(order: widget.order),
                      const SizedBox(
                        height: TSizes.spaceBtwSections,
                      ),
                      OrderTransaction(
                        order: widget.order,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: TSizes.spaceBtwSections,
                ),
                // Right side
                Expanded(
                  child: Column(
                    children: [
                      OrderCustomerInfo(
                        order: widget.order,
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwSections,
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    ));
  }
}
