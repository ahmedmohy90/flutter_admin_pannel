import 'package:admin_pannel/common/widgets/data_table/paginated_data_table.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/category/category_controller.dart';
import 'category_rows.dart';

class CategoryTableWidget extends StatelessWidget {
  const CategoryTableWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryController());
    return Obx(
      () {
        print(controller.filteredItems.length);
        print(controller.selectedRows.length);
        return TPaginatedDataTable(
            sortAscending: controller.sortAscending.value,
            sortColumnIndex: controller.sortColumnIndex.value,
            minWidth: 700,
            columns: [
              DataColumn2(
                  label: const Text('Category'),
                  onSort: (columnIndex, ascending) {
                    controller.sortByName(columnIndex, ascending);
                  }),
              DataColumn2(
                  label: const Text('Parent Category'),
                  onSort: (columnIndex, ascending) {
                    controller.sortByName(columnIndex, ascending);
                  }),
              const DataColumn2(label: Text('Featured')),
              const DataColumn2(label: Text('Date')),
              const DataColumn2(label: Text('Action'), fixedWidth: 100),
            ],
            source: CategoryRows());
      },
    );
  }
}
