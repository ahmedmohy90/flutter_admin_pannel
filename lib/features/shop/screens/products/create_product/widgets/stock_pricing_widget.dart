import 'package:admin_pannel/features/shop/controllers/product/create_product_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../../../utils/constants/enums.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/validators/validation.dart';

class ProductStockAndPricing extends StatelessWidget {
  const ProductStockAndPricing({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CreateProductController.instance;
    return Obx(
    ()=>   
      controller.productType.value == ProductType.single
      ?
     Form(
      key: controller.stockPriceFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FractionallySizedBox(
              widthFactor: 0.45,
              child: TextFormField(
                controller: controller.productStockController,
                validator: (value) =>
                    TValidator.validateEmptyText('Stock', value),
                decoration: const InputDecoration(
                    labelText: 'Stock',
                    hintText: 'Add Stock, only numbers are allowed'),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
              ),
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),
            Row(children: [
              Expanded(
                child: TextFormField(
                  controller: controller.productPriceController,
                  validator: (value) =>
                      TValidator.validateEmptyText('Price', value),
                  decoration: const InputDecoration(
                      labelText: 'Price',
                      hintText: 'price with up-to 2 decimals'),
                  keyboardType:const  TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}$')),
                  ],
                ),
              ),
              const SizedBox(
                width: TSizes.spaceBtwItems,),
              Expanded(
                child: TextFormField(
                  controller: controller.productSalesPriceController,
                  validator: (value) =>
                      TValidator.validateEmptyText('Sale Price', value),
                  decoration: const InputDecoration(
                      labelText: 'Discount  Price',
                      hintText: 'price with up-to 2 decimals'),
                  keyboardType:const  TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}$')),
                  ],
                ),
              ),
            ])
          ],
        ),
      ):const SizedBox(),
    );
  }
}
