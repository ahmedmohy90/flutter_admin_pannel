import 'dart:developer';

import 'package:admin_pannel/common/widgets/icons/table_action_icon_buttons.dart';
import 'package:admin_pannel/common/widgets/images/t_rounded_image.dart';
import 'package:admin_pannel/routes/routes.dart';
import 'package:admin_pannel/utils/constants/colors.dart';
import 'package:admin_pannel/utils/constants/enums.dart';
import 'package:admin_pannel/utils/constants/image_strings.dart';
import 'package:admin_pannel/utils/device/device_utility.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../utils/constants/sizes.dart';
import '../../../../controllers/product/products_controller.dart';

class ProductRows extends DataTableSource {
  final controller = ProductsController.instance;
  @override
  DataRow? getRow(int index) {
    final product = controller.filteredItems[index];
    log(product.toString());
    return DataRow2(
        selected: controller.selectedRows[index],
        onTap: () => Get.toNamed(TRoutes.editProduct, arguments: product),
        onSelectChanged: (value) =>
            controller.selectedRows[index] = value ?? false,
        cells: [
          DataCell(
            Row(
              children: [
                TRoundedImage(
                  width: 50,
                  height: 50,
                  padding: TSizes.sm,
                  image: product.thumbnail,
                  imageType: ImageType.network,
                  borderRadius: TSizes.borderRadiusMd,
                  backgroundColor: TColors.primaryBackground,
                ),
                const SizedBox(
                  width: TSizes.spaceBtwItems,
                ),
                Flexible(
                  child: Text(
                    product.title,
                    style: Theme.of(Get.context!)
                        .textTheme
                        .bodyLarge!
                        .apply(color: TColors.primary),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          DataCell(
            Text(controller.getProductStockTotal(product)),
          ),
          DataCell(
            Text(controller.getProductSoldQuantity(product)),
          ),
          DataCell(
            Row(
              children: [
                TRoundedImage(
                  width: 35,
                  height: 35,
                  padding: TSizes.sm,
                  image: product.brand != null
                      ? product.brand!.image
                      : TImages.defaultImage,
                  imageType: product.brand != null
                      ? ImageType.network
                      : ImageType.asset,
                  borderRadius: TSizes.borderRadiusMd,
                  backgroundColor: TColors.primaryBackground,
                ),
                const SizedBox(
                  width: TSizes.spaceBtwItems,
                ),
                Flexible(
                  child: Text(
                    product.brand != null ? product.brand!.name : '',
                    style: Theme.of(Get.context!)
                        .textTheme
                        .bodyLarge!
                        .apply(color: TColors.primary),
                  ),
                ),
              ],
            ),
          ),
          DataCell(Text('\$${controller.getProductPrice(product)}')),
          DataCell(Text(product.formattedDate)),
          DataCell(TTableActionButtons(
            onEditPressed: () =>
                Get.toNamed(TRoutes.editProduct, arguments: product),
            onDeletePressed: () => controller.confirmAndDeleteItem(product),
          )),
        ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => controller.filteredItems.length;

  @override
  int get selectedRowCount => controller.selectedRows.where((selected)=>selected).length;
}
