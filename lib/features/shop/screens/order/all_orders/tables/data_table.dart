import 'package:admin_pannel/common/widgets/data_table/paginated_data_table.dart';
import 'package:admin_pannel/utils/device/device_utility.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/order/order_controller.dart';
import 'table_source.dart';

class OrderTable extends StatelessWidget {
  const OrderTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderController());
    return Obx(() {
      print(controller.filteredItems.length.toString());
      print(controller.selectedRows.length.toString());
      return TPaginatedDataTable(
          minWidth: 700,
          columns: [
            const DataColumn2(
              label: Text('Order ID'),
            ),
            DataColumn2(
                label: const Text('Date'),
                onSort: (columnIndex, ascending) =>
                    controller.sortByDate(columnIndex, ascending)),
            const DataColumn2(
              label: Text('Items'),
            ),
            DataColumn2(
                label: const Text('status'),
                fixedWidth: TDeviceUtils.isMobileScreen(context) ? 120 : null),
            const DataColumn2(
              label: Text('Amount'),
            ),
            const DataColumn2(
              label: Text('Action'),
              fixedWidth: 100,
            ),
          ],
          source: OrderRows());
    });
  }
}
