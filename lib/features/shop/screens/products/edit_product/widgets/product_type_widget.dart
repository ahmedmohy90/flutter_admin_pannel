import 'package:admin_pannel/features/shop/controllers/product/edit_product_controller.dart';
import 'package:admin_pannel/features/shop/models/product_model.dart';
import 'package:admin_pannel/utils/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../utils/constants/sizes.dart';

class ProductTypeWidget extends StatelessWidget {
  const ProductTypeWidget({super.key});


  @override
   Widget build(BuildContext context) {
    final controller = EditProductController.instance;
    return Obx(() {
      return Row(
        children: [
          Text(
            'Product Type',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(
            width: TSizes.spaceBtwItems,
          ),
          RadioMenuButton(
            value: ProductType.single,
            groupValue: controller.productType.value,
            onChanged: (value) {
              controller.productType.value = value ?? ProductType.single;
            },
            child: const Text('Single'),
          ),
          RadioMenuButton(
            value: ProductType.variable,
            groupValue: controller.productType.value,
            onChanged: (value) {
              controller.productType.value = value ?? ProductType.single;
            },
            child: const Text('Variable'),
          ),
        ],
      );
    });
  }
}