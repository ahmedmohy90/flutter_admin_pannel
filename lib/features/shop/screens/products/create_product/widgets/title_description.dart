import 'package:admin_pannel/common/widgets/containers/rounded_container.dart';
import 'package:admin_pannel/features/shop/controllers/product/create_product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/validators/validation.dart';

class ProductTitleAndDescription extends StatelessWidget {
  const ProductTitleAndDescription({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateProductController());
    return TRoundedContainer(
      child: Form(
          key: controller.titleDescreptionFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Basic Information',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              TextFormField(
                controller: controller.productTitleController,
                validator: (value) =>
                    TValidator.validateEmptyText('Product Title', value),
                decoration: const InputDecoration(
                  labelText: 'Product Title',
                ),
              ),
              const SizedBox(
                height: TSizes.spaceBtwInputFields,
              ),
              SizedBox(
                height: 300,
                child: TextFormField(
                  expands: true,
                  maxLines: null,
                  textAlign: TextAlign.start,
                  controller: controller.productDescriptionController,
                  keyboardType: TextInputType.multiline,
                  textAlignVertical: TextAlignVertical.top,
                  validator: (value) => TValidator.validateEmptyText(
                      'Product Description', value),
                  decoration: const InputDecoration(
                      labelText: 'Product Description',
                      hintText: 'Add your Product Description here...',
                      alignLabelWithHint: true),
                ),
              )
            ],
          )),
    );
  }
}
