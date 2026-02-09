import 'package:admin_pannel/common/widgets/containers/rounded_container.dart';
import 'package:admin_pannel/common/widgets/images/t_rounded_image.dart';
import 'package:admin_pannel/features/shop/controllers/order/order_details_controller.dart';
import 'package:admin_pannel/features/shop/models/order_model.dart';
import 'package:admin_pannel/utils/constants/colors.dart';
import 'package:admin_pannel/utils/constants/enums.dart';
import 'package:admin_pannel/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../utils/constants/sizes.dart';
import '../../../../controllers/order/order_controller.dart';

class OrderCustomerInfo extends StatefulWidget {
  const OrderCustomerInfo({super.key, required this.order});

  final OrderModel order;

  @override
  State<OrderCustomerInfo> createState() => _OrderCustomerInfoState();
}

class _OrderCustomerInfoState extends State<OrderCustomerInfo> {
  late final OrderDetailsController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(OrderDetailsController());
    controller.order.value = widget.order;
    controller.getCustomerOfCurrentOrder(); // ✅ هنا فقط
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TRoundedContainer(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Title
              Text(
                'Customer',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// Customer Basic Info
              Obx(
                () => Row(
                  children: [
                    TRoundedImage(
                      padding: 0,
                      imageType: controller
                                  .customer.value.profilePicture?.isNotEmpty ==
                              true
                          ? ImageType.network
                          : ImageType.asset,
                      image: controller
                                  .customer.value.profilePicture?.isNotEmpty ==
                              true
                          ? controller.customer.value.profilePicture!
                          : TImages.user,
                      backgroundColor: TColors.primaryBackground,
                    ),
                    const SizedBox(width: TSizes.spaceBtwItems),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.customer.value.fullName,
                            style: Theme.of(context).textTheme.titleLarge,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            controller.customer.value.email!,
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwSections),

        /// Shipping Info
        Obx(
          () => SizedBox(
            width: double.infinity,
            child: TRoundedContainer(
              padding: EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Contact Person',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  Text(
                    controller.customer.value.fullName,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems / 2),
                  Text(
                    controller.customer.value.email!,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems / 2),
                  Text(
                    controller.customer.value.formatedPhoneNumber.isNotEmpty
                        ? controller.customer.value.formatedPhoneNumber
                        : '(+20) *** *** ***',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwSections),
        SizedBox(
          width: double.infinity,
          child: TRoundedContainer(
            padding: EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Shipping Address',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: TSizes.spaceBtwSections),
                Text(
                  widget.order.shippingAddress != null
                      ? widget.order.shippingAddress!.name
                      : '',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: TSizes.spaceBtwItems / 2),
                Text(
                  widget.order.shippingAddress != null
                      ? widget.order.shippingAddress!.toString()
                      : '',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: TSizes.spaceBtwSections),

        SizedBox(
          width: double.infinity,
          child: TRoundedContainer(
            padding: EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Billing Address',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: TSizes.spaceBtwSections),
                Text(
                  widget.order.billingAddressSameAsShipping
                      ? widget.order.shippingAddress!.name
                      : widget.order.billingAddress!.name,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: TSizes.spaceBtwItems / 2),
                Text(
                  widget.order.billingAddressSameAsShipping
                      ? widget.order.shippingAddress!.toString()
                      : widget.order.billingAddress!.toString(),
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
