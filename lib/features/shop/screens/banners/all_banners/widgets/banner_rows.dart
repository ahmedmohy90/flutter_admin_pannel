import 'package:admin_pannel/common/widgets/icons/table_action_icon_buttons.dart';
import 'package:admin_pannel/common/widgets/images/t_rounded_image.dart';
import 'package:admin_pannel/features/shop/controllers/banner/banner_controller.dart';
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
import '../../../../models/banner_model.dart';

class BannerRows extends DataTableSource {
  final controller = BannerController.instance;
  @override
  DataRow? getRow(int index) {
    final banner = controller.filteredItems[index];
    return DataRow2(
        selected: controller.selectedRows[index],
        onTap: () => Get.toNamed(TRoutes.editBanner, arguments: banner),
        onSelectChanged: (value) =>
            controller.selectedRows[index] = value ?? false,
        cells: [
          DataCell(
            TRoundedImage(
              width: 180,
              height: 100,
              padding: TSizes.sm,
              image: banner.imageUrl,
              imageType: ImageType.network,
              borderRadius: TSizes.borderRadiusMd,
              backgroundColor: TColors.primaryBackground,
            ),
          ),
          DataCell(Text(controller.formatRoute(banner.targetScreen))),
          DataCell(banner.active
              ? const Icon(Iconsax.eye, color: TColors.primary)
              : const Icon(Iconsax.eye_slash, color: TColors.primary)),
          DataCell(TTableActionButtons(
            onEditPressed: () =>
                Get.toNamed(TRoutes.editBanner, arguments: banner),
            onDeletePressed: () => controller.confirmAndDeleteItem(banner),
          )),
        ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => controller.filteredItems.length;

  @override
  int get selectedRowCount => controller.selectedRows.where((element) => element).length;
}
