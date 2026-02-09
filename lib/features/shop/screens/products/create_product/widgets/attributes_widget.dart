import 'package:admin_pannel/common/widgets/containers/rounded_container.dart';
import 'package:admin_pannel/common/widgets/images/t_rounded_image.dart';
import 'package:admin_pannel/features/shop/controllers/product/create_product_controller.dart';
import 'package:admin_pannel/utils/constants/enums.dart';
import 'package:admin_pannel/utils/constants/image_strings.dart';
import 'package:admin_pannel/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/validators/validation.dart';
import '../../../../controllers/product/attributes_controller.dart';
import '../../../../controllers/product/variation_controller.dart';

class ProductAttributes extends StatelessWidget {
  const ProductAttributes({super.key});

  @override
  Widget build(BuildContext context) {
    // controllers
    final productController = CreateProductController.instance;
    final attributeController = Get.put(ProductAttributesController());
   final variationController = Get.put(ProductVariationController());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() {
          return productController.productType.value == ProductType.single
              ? const Column(
                  children: [
                    Divider(
                      color: TColors.primaryBackground,
                    ),
                    SizedBox(
                      height: TSizes.spaceBtwSections,
                    )
                  ],
                )
              : const SizedBox.shrink();
        }),
        const SizedBox(
          height: TSizes.spaceBtwSections,
        ),
        Text(
          'Add Product Attributes',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems,
        ),
        Form(
          key: attributeController.attributesFormKey,
          child: TDeviceUtils.isDesktopScreen(context)
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _buildAttributeName(attributeController),
                    ),
                    const SizedBox(
                      width: TSizes.spaceBtwItems,
                    ),
                    Expanded(
                      flex: 2,
                      child: _buildAttributeTextField(attributeController),
                    ),
                    const SizedBox(
                      width: TSizes.spaceBtwItems,
                    ),
                    _buildAddAtributeButton(attributeController),
                  ],
                )
              : Column(
                  children: [
                    _buildAttributeName(attributeController),
                    const SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),
                    _buildAttributeTextField(attributeController),
                    const SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),
                    _buildAddAtributeButton(attributeController),
                  ],
                ),
        ),
        const SizedBox(
          height: TSizes.spaceBtwSections,
        ),
        Text('All Attributes',
            style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(
          height: TSizes.spaceBtwItems,
        ),
        TRoundedContainer(
          backgroundColor: TColors.primaryBackground,
          child: Obx(
            () => attributeController.productAttributes.isNotEmpty
                ? ListView.separated(
                    shrinkWrap: true,
                    itemCount: attributeController.productAttributes.length,
                    separatorBuilder: (_, index) => const SizedBox(
                          height: TSizes.spaceBtwItems,
                        ),
                    itemBuilder: (_, index) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(TSizes.borderRadiusLg),
                        ),
                        child: ListTile(
                          title: Text(
                            attributeController.productAttributes[index].name ??
                                '',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          subtitle: Text(
                            attributeController.productAttributes[index].values!
                                .map((e) => e.trim())
                                .toString(),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Iconsax.trash),
                            color: TColors.error,
                            onPressed: () => attributeController
                                .removeAttribute(index, context),
                          ),
                        ),
                      );
                    })
                : buildEmptyAttributes(),
          ),
        ),
        const SizedBox(
          height: TSizes.spaceBtwSections,
        ),
        Obx(
          () =>
          productController.productType.value == ProductType.variable && variationController.productVariations.isEmpty
          ?
           Center(
            child: SizedBox(
              width: 200,
              child: ElevatedButton.icon(
                onPressed: () => variationController.generateVariationsConfirmation(context),
                icon: const Icon(Iconsax.activity),
                label: const Text('Generate Variations'),
              ),
            ),
          ):const SizedBox.shrink(),
        )
      ],
    );
  }

  TextFormField _buildAttributeName(ProductAttributesController controller) {
    return TextFormField(
      controller: controller.attributeName,
      validator: (value) =>
          TValidator.validateEmptyText('Attribute Name', value),
      decoration: const InputDecoration(
        labelText: 'Attribute Name',
        hintText: 'Colors, Sizes, Material',
      ),
    );
  }

  SizedBox _buildAttributeTextField(ProductAttributesController controller) {
    return SizedBox(
      height: 80,
      child: TextFormField(
          controller: controller.attributes,
          expands: true,
          maxLines: null,
          textAlign: TextAlign.start,
          keyboardType: TextInputType.multiline,
          textAlignVertical: TextAlignVertical.top,
          validator: (value) =>
              TValidator.validateEmptyText('Attribute Field', value),
          decoration: const InputDecoration(
              labelText: 'Attribute',
              hintText:
                  'Add your attribute Seperated by |  Example : Red | Green | Blue',
              alignLabelWithHint: true)),
    );
  }

  /// Builds an elevated button with a label of 'Add' and an icon of 'add'.
  SizedBox _buildAddAtributeButton(ProductAttributesController controller) {
    return SizedBox(
      width: 100,
      child: ElevatedButton.icon(
        onPressed: () => controller.addNewAttribute(),
        label: const Text('Add'),
        icon: const Icon(Iconsax.add),
        style: ElevatedButton.styleFrom(
            foregroundColor: TColors.black,
            backgroundColor: TColors.secondary,
            side: const BorderSide(color: TColors.secondary)),
      ),
    );
  }

  buildEmptyAttributes() {
    return const Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TRoundedImage(
              width: 150,
              height: 80,
              imageType: ImageType.asset,
              image: TImages.defaultAttributeColorsImageIcon,
            )
          ],
        ),
        SizedBox(
          height: TSizes.spaceBtwItems,
        ),
        Text('There are no attributes added for this product')
      ],
    );
  }
}
