import 'package:admin_pannel/common/widgets/data_table/paginated_data_table.dart';
import 'package:admin_pannel/features/shop/screens/products/all_products/widgets/product_rows.dart';
import 'package:admin_pannel/utils/device/device_utility.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/product/products_controller.dart';

class ProductTableWidget extends StatelessWidget {
  const ProductTableWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductsController());
    return Obx(() {
      Visibility(
        visible: false,
        child: Text(controller.filteredItems.length.toString()),
      );
      Visibility(
        visible: false,
        child: Text(controller.selectedRows.length.toString()),
      );
      return TPaginatedDataTable(
          minWidth: 1000,
          sortAscending: controller.sortAscending.value,
          sortColumnIndex: controller.sortColumnIndex.value,
          columns: [
            DataColumn2(
                label: const Text('Product'),
                fixedWidth:
                    TDeviceUtils.isMobileScreen(Get.context!) ? 300 : 400,
                onSort: (columnIndex, ascending) =>
                    controller.sortByName(columnIndex, ascending)),
            DataColumn2(
                label: const Text('Stock'),
                onSort: (columnIndex, ascending) =>
                    controller.sortByStock(columnIndex, ascending)),
            DataColumn2(
              label: const Text('Sold'),
              onSort: (columnIndex, ascending) => controller.sortBySoldItems(
                columnIndex,
                ascending,
              ),
            ),
            const DataColumn2(
              label: Text('Brand'),
            ),
             DataColumn2(
              label:const  Text('Price'),
                            onSort: (columnIndex, ascending) => controller.sortByPrice(
                              columnIndex,
                              ascending,
                            ),

            ),
            const DataColumn2(
              label: Text('Date'),
            ),
            const DataColumn2(label: Text('Action'), fixedWidth: 100),
          ],
          source: ProductRows());
    });
  }
}
