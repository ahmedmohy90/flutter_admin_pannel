import 'package:admin_pannel/common/widgets/containers/rounded_container.dart';
import 'package:admin_pannel/utils/helpers/helper_functions.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/dashboard/dashboard_controller.dart';

class OrderRows extends DataTableSource {
  @override
  bool get isRowCountApproximate => false;

  @override
  DataRow? getRow(int index) {
    final order = DashboardController.orders[index];
    return DataRow2(cells: [
      DataCell(Text(
        order.id,
        style: Theme.of(Get.context!)
            .textTheme
            .bodyLarge!
            .apply(color: TColors.primary),
      )),
      DataCell(Text(order.formattedOrderDate)),
      const DataCell(Text('5 items')),
      DataCell(TRoundedContainer(
          radius: TSizes.cardRadiusSm,
          padding: const EdgeInsets.symmetric(
              horizontal: TSizes.md, vertical: TSizes.xs),
          backgroundColor: THelperFunctions.getOrderStatusColor(order.status)
              .withOpacity(0.1),
          child: Text(
            order.status.name.toString(),
            style: TextStyle(
                color: THelperFunctions.getOrderStatusColor(order.status)),
          ))),
      DataCell(Text(order.totalAmount.toString())),
    ]);
  }

  @override
  int get rowCount => DashboardController.orders.length;

  @override
  int get selectedRowCount => 0;
}
