import 'package:admin_pannel/common/widgets/data_table/paginated_data_table.dart';
import 'package:admin_pannel/features/shop/controllers/customer/customer_controller.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'table_source.dart';

class CustomersTable extends StatelessWidget {
  const CustomersTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CustomerController());
    return Obx(

     (){ 
        print(controller.filteredItems.length);
        print(controller.selectedRows.length);
      return TPaginatedDataTable(
          minWidth: 700,
          sortAscending: controller.sortAscending.value,
          sortColumnIndex: controller.sortColumnIndex.value,
          columns:  [
            DataColumn2(
              label: const Text('Customer'),
              onSort: (columnIndex, ascending) => controller.sortByName(columnIndex, ascending),
            ),
           const  DataColumn2(
              label: Text('Email'),
            ),
           const  DataColumn2(
              label: Text('Phone Number'),
            ),
           const  DataColumn2(
              label: Text('Registered'),
            ),
           const  DataColumn2(
              label: Text('Action'),
              fixedWidth: 100,
            ),
          ],
          source: CustomerRows());}
    );
  }
}
