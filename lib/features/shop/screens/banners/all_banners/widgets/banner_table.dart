import 'package:admin_pannel/common/widgets/data_table/paginated_data_table.dart';
import 'package:admin_pannel/utils/device/device_utility.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/banner/banner_controller.dart';
import 'banner_rows.dart';

class BannerTableWidget extends StatelessWidget {
  const BannerTableWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BannerController>();
    return Obx(
      () {
        print(controller.filteredItems.length);
        print(controller.selectedRows.length);
        return TPaginatedDataTable(
          minWidth: 700,
          tableHeight: 900,
          dataRowHeight: 110,
          columns: const [
            DataColumn2(label: Text('Banner')),
            DataColumn2(label: Text('Redirect Screen')),
            DataColumn2(label: Text('Active')),
            DataColumn2(label: Text('Action'), fixedWidth: 100),
          ],
          source: BannerRows(),
        );
      },
    );
  }
}
