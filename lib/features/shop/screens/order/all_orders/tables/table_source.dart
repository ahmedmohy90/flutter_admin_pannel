import 'package:admin_pannel/common/widgets/containers/rounded_container.dart';
import 'package:admin_pannel/common/widgets/images/t_rounded_image.dart';
import 'package:admin_pannel/features/authentication/models/user_model.dart';
import 'package:admin_pannel/features/shop/controllers/dashboard/dashboard_controller.dart';
import 'package:admin_pannel/features/shop/controllers/order/order_controller.dart';
import 'package:admin_pannel/features/shop/models/order_model.dart';
import 'package:admin_pannel/utils/constants/colors.dart';
import 'package:admin_pannel/utils/constants/enums.dart';
import 'package:admin_pannel/utils/constants/image_strings.dart';
import 'package:admin_pannel/utils/helpers/helper_functions.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/widgets/icons/table_action_icon_buttons.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/sizes.dart';

class OrderRows extends DataTableSource {
  final controller = OrderController.instance;
  @override
  DataRow? getRow(int index) {
    final order = controller.filteredItems[index];

    return DataRow2(
        onTap: () => Get.toNamed(TRoutes.orderDetails,
            arguments: order, parameters: {'orderId': order.docId}),
        onSelectChanged: (value) =>
            controller.selectedRows[index] = value ?? false,
        selected: controller.selectedRows[index],
        cells: [
          DataCell(Text(
            order.id,
            style: Theme.of(Get.context!)
                .textTheme
                .bodyLarge!
                .apply(color: TColors.primary),
          )),
          DataCell(Text(order.formattedOrderDate)),
          DataCell(Text('${order.items.length} items')),
          DataCell(TRoundedContainer(
            radius: TSizes.cardRadiusSm,
            padding: const EdgeInsets.symmetric(
              vertical: TSizes.cardRadiusSm,
              horizontal: TSizes.md,
            ),
            backgroundColor: THelperFunctions.getOrderStatusColor(order.status)
                .withOpacity(0.1),
            child: Text(
              order.status.name.capitalize.toString(),
              style: Theme.of(Get.context!).textTheme.bodyLarge!.apply(
                  color: THelperFunctions.getOrderStatusColor(order.status)),
            ),
          )),
          DataCell(Text('\$${order.totalAmount}')),
          DataCell(
            TTableActionButtons(
              view: true,
              edit: false,
              onViewPressed: () => Get.toNamed(TRoutes.orderDetails,
                  arguments: order, parameters: {'orderId': order.docId}),
              onDeletePressed: () => controller.confirmAndDeleteItem(order),
            ),
          )
        ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => controller.filteredItems.length;

  @override
  int get selectedRowCount =>
      controller.selectedRows.where((element) => element).toList().length;
}
