import 'package:admin_pannel/common/widgets/data_table/paginated_data_table.dart';
import 'package:admin_pannel/features/shop/controllers/customer/customer_controller.dart';
import 'package:admin_pannel/utils/device/device_utility.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'table_source.dart';

class CustomerOrderTable extends StatelessWidget {
  const CustomerOrderTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CustomerController.instance;

    return Obx(
      () {
        print(controller.filteredItems.length);
        print(controller.selectedRows.length);
        return TPaginatedDataTable(
          minWidth: 550,
          tableHeight: 640,
          dataRowHeight: kMinInteractiveDimension,
          sortAscending: controller.sortAscending.value,
          sortColumnIndex: controller.sortColumnIndex.value,
          columns: [
             DataColumn2(
              label: Text('Order ID'),
              onSort: (columnIndex, ascending) => controller.sortByName(columnIndex, ascending)
            ),
            const DataColumn2(
              label: Text('Date'),
            ),
            const DataColumn2(
              label: Text('Items'),
            ),
            DataColumn2(
                label: const Text('Status'),
                fixedWidth: TDeviceUtils.isMobileScreen(context) ? 100 : null),
            const DataColumn2(label: Text('Amount'), numeric: true),
          ],
          source: CustomerOrdersRows(),
        );
      },
    );
  }
}
