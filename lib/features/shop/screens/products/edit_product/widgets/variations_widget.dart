import 'package:admin_pannel/common/widgets/containers/rounded_container.dart';
import 'package:admin_pannel/common/widgets/images/image_uploader.dart';
import 'package:admin_pannel/common/widgets/images/t_rounded_image.dart';
import 'package:admin_pannel/utils/constants/colors.dart';
import 'package:admin_pannel/utils/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../../../utils/constants/image_strings.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../controllers/product/create_product_controller.dart';
import '../../../../controllers/product/product_images_controller.dart';
import '../../../../controllers/product/variation_controller.dart';
import '../../../../models/product_variation_model.dart';

class ProductVariations extends StatelessWidget {
  const ProductVariations({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CreateProductController());
    final variationController = ProductVariationController.instance;
    return Obx(
      () => CreateProductController.instance.productType.value ==
              ProductType.variable
          ? TRoundedContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Product Variations',
                          style: Theme.of(context).textTheme.headlineSmall),
                      TextButton(
                        onPressed: () =>
                            variationController.removeVariations(context),
                        child: const Text('Remove Variations'),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  if (variationController.productVariations.isNotEmpty)
                    ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (_, index) {
                        final vatiation =
                            variationController.productVariations[index];
                        return _buildVariationTile(
                            context, index, vatiation, variationController);
                      },
                      separatorBuilder: (_, index) => const SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),
                      itemCount: variationController.productVariations.length,
                    )
                  else
                    _buildNoVariationsMessage(),
                ],
              ),
            )
          : const SizedBox.shrink(),
    );
  }

  Widget _buildVariationTile(
      BuildContext context,
      int index,
      ProductVariationModel variation,
      ProductVariationController variationController) {
    return ExpansionTile(
      backgroundColor: TColors.lightGrey,
      collapsedBackgroundColor: TColors.lightGrey,
      childrenPadding: const EdgeInsets.all(TSizes.md),
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(TSizes.borderRadiusLg)),
      title: Text(variation.attributesValues.entries
          .map((entry) => '${entry.key}: ${entry.value}')
          .join(', ')),
      children: [
        Obx(
          () => TImageUploader(
            right: 0,
            left: null,
            imageType: variation.image.isNotEmpty
                ? ImageType.network
                : ImageType.asset,
            image: variation.image.value.isNotEmpty
                ? variation.image.value
                : TImages.defaultImage,
            onIconButtonPressed: () => ProductImagesController.instance
                .selectVariationImage(variation),
          ),
        ),
        const SizedBox(
          height: TSizes.spaceBtwInputFields,
        ),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                onChanged: (value) => variation.stock = int.parse(value),
                controller: variationController.stockControllerList[index]
                    [variation],
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: const InputDecoration(
                  labelText: 'Stock',
                  hintText: 'Add Stock, only numbers are allowed',
                ),
              ),
            ),
            const SizedBox(
              width: TSizes.spaceBtwInputFields,
            ),
            Expanded(
              child: TextFormField(
                onChanged: (value) => variation.price = double.parse(value),
                controller: variationController.priceControllerList[index]
                    [variation],
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}$'))
                ],
                decoration: const InputDecoration(
                  labelText: 'Price',
                  hintText: 'Price with up-to 2 decimals',
                ),
              ),
            ),
            const SizedBox(
              width: TSizes.spaceBtwInputFields,
            ),
            Expanded(
              child: TextFormField(
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}$'))
                ],
                decoration: const InputDecoration(
                  labelText: 'Discount Price',
                  hintText: 'Price with up-to 2 decimals',
                ),
                controller: variationController.salePriceControllerList[index]
                    [variation],
                onChanged: (value) => variation.salePrice = double.parse(value),
              ),
            ),
          ],
        ),
        const SizedBox(
          width: TSizes.spaceBtwInputFields,
        ),
        TextFormField(
          onChanged: (value) => variation.description = value,
          controller: variationController.discriptionControllerList[index]
              [variation],
          decoration: const InputDecoration(
            labelText: 'Description',
            hintText: 'Add description for this variation...',
          ),
        ),
        const SizedBox(
          width: TSizes.spaceBtwInputFields,
        ),
      ],
    );
  }

  _buildNoVariationsMessage() {
    return const Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TRoundedImage(
              width: 200,
              height: 200,
              imageType: ImageType.asset,
              image: TImages.defaultVariationImageIcon,
            )
          ],
        ),
        SizedBox(
          height: TSizes.spaceBtwItems,
        ),
        Text(
          'There is No Variations added for this product',
        ),
      ],
    );
  }
}
