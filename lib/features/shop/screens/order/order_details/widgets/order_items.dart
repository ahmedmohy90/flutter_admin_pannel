import 'package:admin_pannel/common/widgets/containers/rounded_container.dart';
import 'package:admin_pannel/common/widgets/images/t_rounded_image.dart';
import 'package:admin_pannel/features/shop/models/order_model.dart';
import 'package:admin_pannel/utils/constants/colors.dart';
import 'package:admin_pannel/utils/constants/enums.dart';
import 'package:admin_pannel/utils/constants/image_strings.dart';
import 'package:admin_pannel/utils/device/device_utility.dart';
import 'package:admin_pannel/utils/helpers/pricing_calculator.dart';
import 'package:flutter/material.dart';

import '../../../../../../utils/constants/sizes.dart';

class OrderItems extends StatelessWidget {
  const OrderItems({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final subTotal = order.items.fold<double>(
      0,
      (previousValue, element) =>
          previousValue + (element.price * element.quantity),
    );

    return TRoundedContainer(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Title
          Text(
            'Items',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: TSizes.spaceBtwSections),

          /// Items List
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: order.items.length,
            separatorBuilder: (_, __) =>
                const SizedBox(height: TSizes.spaceBtwItems),
            itemBuilder: (context, index) {
              final item = order.items[index];

              return Row(
                children: [
                  /// Image + Name
                  Expanded(
                    child: Row(
                      children: [
                        TRoundedImage(
                          backgroundColor: TColors.primaryBackground,
                          imageType: item.image != null
                              ? ImageType.network
                              : ImageType.asset,
                          image: item.image ?? TImages.defaultImage,
                        ),
                        const SizedBox(width: TSizes.spaceBtwItems),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                item.title,
                                style: Theme.of(context).textTheme.titleMedium,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              if (item.selectedVariation != null)
                                Text(
                                  item.selectedVariation!.entries
                                      .map((e) => '${e.key}: ${e.value} ')
                                      .join(','),
                                  style: Theme.of(context).textTheme.bodySmall,
                                )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// Price
                  SizedBox(
                    width: TSizes.xl * 2,
                    child: Text(
                      '\$${item.price.toStringAsFixed(1)}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),

                  /// Quantity
                  SizedBox(
                    width: TDeviceUtils.isMobileScreen(context)
                        ? TSizes.xl * 1.4
                        : TSizes.xl * 2,
                    child: Text(
                      item.quantity.toString(),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),

                  /// Total
                  SizedBox(
                    width: TDeviceUtils.isMobileScreen(context)
                        ? TSizes.xl * 1.4
                        : TSizes.xl * 2,
                    child: Text(
                      '\$${(item.totalAmount)}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ],
              );
            },
          ),

          const SizedBox(height: TSizes.spaceBtwSections),

          /// Summary
          TRoundedContainer(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            borderColor: TColors.primaryBackground,
            child: Column(
              children: [
                _summaryRow(
                  context,
                  label: 'Subtotal',
                  value: '\$$subTotal',
                  valueStyle: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: TSizes.spaceBtwItems),
                _summaryRow(
                  context,
                  label: 'Discount',
                  value: '\$0.00',
                ),
                const SizedBox(height: TSizes.spaceBtwItems),
                _summaryRow(
                  context,
                  label: 'Shipping',
                  value: '\$${order.shippingCost.toStringAsFixed(2)}',
                ),
                const SizedBox(height: TSizes.spaceBtwItems),
                _summaryRow(
                  context,
                  label: 'Tax',
                  value: '\$${order.taxCost.toStringAsFixed(2)}',
                ),
                const SizedBox(height: TSizes.spaceBtwItems),
                const Divider(),
                const SizedBox(height: TSizes.spaceBtwItems),
                _summaryRow(
                  context,
                  label: 'Total',
                  value:
                      '\$${(subTotal + order.shippingCost + order.taxCost).toStringAsFixed(2)}',
                  isBold: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Reusable Summary Row
  Widget _summaryRow(
    BuildContext context, {
    required String label,
    required String value,
    TextStyle? valueStyle,
    bool isBold = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Text(
          value,
          style: valueStyle ??
              (isBold
                  ? Theme.of(context).textTheme.titleLarge
                  : Theme.of(context).textTheme.titleLarge),
        ),
      ],
    );
  }
}
