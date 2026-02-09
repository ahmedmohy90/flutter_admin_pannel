import 'package:admin_pannel/common/widgets/icons/table_action_icon_buttons.dart';
import 'package:admin_pannel/common/widgets/images/t_rounded_image.dart';
import 'package:admin_pannel/features/shop/controllers/category/category_controller.dart';
import 'package:admin_pannel/routes/routes.dart';
import 'package:admin_pannel/utils/constants/colors.dart';
import 'package:admin_pannel/utils/constants/enums.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../utils/constants/sizes.dart';

class CategoryRows extends DataTableSource {
  final controller = CategoryController.instance;
  @override
  DataRow? getRow(int index) {
    final category = controller.filteredItems[index];
    final parentCategory = controller.filteredItems.firstWhereOrNull(
      (element) => element.id == category.parentId,
    );
    return DataRow2(
        onSelectChanged: (value) =>
            controller.selectedRows[index] = value ?? false,
        selected: controller.selectedRows[index],
        cells: [
          DataCell(
            Row(
              children: [
                TRoundedImage(
                  width: 50,
                  height: 50,
                  padding: TSizes.sm,
                  image: category.imageUrl,
                  imageType: ImageType.network,
                  borderRadius: TSizes.borderRadiusMd,
                  backgroundColor: TColors.primaryBackground,
                ),
                const SizedBox(
                  width: TSizes.spaceBtwItems,
                ),
                Expanded(
                  child: Text(
                    category.name,
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
          DataCell(Text(parentCategory != null ? parentCategory.name : '')),
          DataCell(
            category.isFeatured
                ? const Icon(Iconsax.heart5, color: TColors.primary)
                : const Icon(Iconsax.heart),
          ),
          DataCell(
            Text(category.createdAt == null ? '' : category.formattedDate),
          ),
          DataCell(TTableActionButtons(
            onEditPressed: () =>
                Get.toNamed(TRoutes.editsCategories, arguments: category  ),
            onDeletePressed: () {
              controller.confirmAndDeleteItem(category);
            },
          )),
        ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => controller.filteredItems.length;

  @override
  int get selectedRowCount => 0;
}
