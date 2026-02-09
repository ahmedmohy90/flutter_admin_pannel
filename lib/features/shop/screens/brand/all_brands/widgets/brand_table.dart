import 'package:admin_pannel/common/widgets/data_table/paginated_data_table.dart';
import 'package:admin_pannel/utils/device/device_utility.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/brand/brand_controller.dart';
import 'brand_rows.dart';

class BrandTableWidget extends StatelessWidget {
  const BrandTableWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BrandController());
    return Obx(() {
      print(controller.filteredItems.length);
      print(controller.selectedRows.length);

      final lgTable = controller.filteredItems.any(
        (element) =>
            element.brandCategories != null &&
            element.brandCategories!.length > 2,
      );
      return TPaginatedDataTable(
          minWidth: 700,
          tableHeight: lgTable ? 96 * 11.5 : 760,
          dataRowHeight: lgTable ? 96 : 64,
          sortAscending: controller.sortAscending.value,
          sortColumnIndex: controller.sortColumnIndex.value,
          columns: [
            DataColumn2(
                label: const Text('Brand'),
                fixedWidth:
                    TDeviceUtils.isMobileScreen(Get.context!) ? null : 200),
            const DataColumn2(label: Text('Categories')),
            DataColumn2(
                label: const Text('Featured'),
                fixedWidth:
                    TDeviceUtils.isMobileScreen(Get.context!) ? null : 100),
            DataColumn2(
                label: const Text('Date'),
                fixedWidth:
                    TDeviceUtils.isMobileScreen(Get.context!) ? null : 200),
            DataColumn2(
                label: const Text('Action'),
                fixedWidth:
                    TDeviceUtils.isMobileScreen(Get.context!) ? null : 100),
          ],
          source: BrandRows());
    });
  }
}
