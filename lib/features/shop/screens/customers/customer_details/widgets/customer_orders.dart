import 'package:admin_pannel/common/widgets/containers/rounded_container.dart';
import 'package:admin_pannel/common/widgets/loaders/animation_loader.dart';
import 'package:admin_pannel/common/widgets/loaders/loader_animation.dart';
import 'package:admin_pannel/features/shop/controllers/customer/customer_detail_controller.dart';
import 'package:admin_pannel/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../table/data_table.dart';

class CustomerOrders extends StatelessWidget {
  const CustomerOrders({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CustomerDetailController.instance;
    controller.getCutomersOrders();

    return TRoundedContainer(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Obx(() {
        if (controller.ordersLoading.value) {
          return const TLoaderAnimation();
        }
        if (controller.allCustomerOrders.isEmpty) {
          return TAnimationLoaderWidget(
              text: 'No Orders Found', animation: TImages.pencilAnimation);
        }
        final totalAmount = controller.allCustomerOrders
            .fold(0.0, (sum, order) => sum + order.totalAmount);
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Orders',
                    style: Theme.of(context).textTheme.headlineMedium),
                Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(text: 'Total Spent '),
                      TextSpan(
                        text: '\$${totalAmount.toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.bodyLarge!.apply(
                              color: TColors.primary,
                            ),
                      ),
                      TextSpan(
                        text:
                            ' on ${controller.allCustomerOrders.length} orders',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            TextFormField(
              controller: controller.searchTextController,
              onChanged: (value) => controller.searchQuery(value),
              decoration: const InputDecoration(
                labelText: 'Search Orders',
                prefixIcon: Icon(
                  Iconsax.search_normal,
                ),
              ),
            ),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),
            const CustomerOrderTable(),
          ],
        );
      }),
    );
  }
}
