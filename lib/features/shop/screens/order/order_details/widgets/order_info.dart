import 'package:admin_pannel/common/widgets/containers/rounded_container.dart';
import 'package:admin_pannel/common/widgets/shimmers/shimmer.dart';
import 'package:admin_pannel/features/shop/controllers/order/order_controller.dart';
import 'package:admin_pannel/features/shop/models/order_model.dart';
import 'package:admin_pannel/utils/constants/enums.dart';
import 'package:admin_pannel/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/helpers/helper_functions.dart';

class OrderInfo extends StatelessWidget {
  const OrderInfo({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderController());
    controller.orderStatus.value = order.status;
    return TRoundedContainer(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Information',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(
            height: TSizes.spaceBtwSections,
          ),
          Row(
            children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Date'),
                  Text(
                    order.formattedOrderDate,
                    style: Theme.of(context).textTheme.bodyLarge,
                  )
                ],
              )),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Items'),
                  Text(
                    '${order.items.length} items',
                    style: Theme.of(context).textTheme.bodyLarge,
                  )
                ],
              )),
              Expanded(
                flex: TDeviceUtils.isMobileScreen(context) ? 2 : 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Status'),
                    Obx(() {
                      if (controller.statusLoader.value) {
                        return const TShimmerEffect(
                            width: double.infinity, height: 55);
                      }
                      return TRoundedContainer(
                          radius: TSizes.cardRadiusSm,
                          padding: const EdgeInsets.symmetric(
                            vertical: 0,
                            horizontal: TSizes.sm,
                          ),
                          backgroundColor: THelperFunctions.getOrderStatusColor(
                                  OrderStatus.pending)
                              .withOpacity(0.1),
                          child: DropdownButton<OrderStatus>(
                              padding: const EdgeInsets.symmetric(vertical: 0),
                              value: controller.orderStatus.value,
                              items:
                                  OrderStatus.values.map((OrderStatus status) {
                                return DropdownMenuItem<OrderStatus>(
                                  value: status,
                                  child: Text(
                                    status.name.capitalize.toString(),
                                    style: TextStyle(
                                        color: THelperFunctions
                                            .getOrderStatusColor(
                                                controller.orderStatus.value)),
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  controller.updateOrderStatus(order, value);
                                }
                              }));
                    })
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Total'),
                    Text(
                      '\$${order.totalAmount.toString()}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
