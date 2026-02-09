import 'package:admin_pannel/common/widgets/containers/rounded_container.dart';
import 'package:admin_pannel/common/widgets/images/t_rounded_image.dart';
import 'package:admin_pannel/features/authentication/models/user_model.dart';
import 'package:admin_pannel/features/shop/controllers/customer/customer_detail_controller.dart';
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

class CustomerOrdersRows extends DataTableSource {
  final controller = CustomerDetailController.instance;
  @override
  DataRow? getRow(int index) {
     if (index >= controller.allCustomerOrders.length) return null;
    final order = controller.allCustomerOrders[index];

    final totalAmount =
        order.items.fold<double>(0, (sum, item) => sum + item.price);
    return DataRow2(
        onTap: () => Get.toNamed(TRoutes.orderDetails, arguments: order),
        selected: controller.selectedRows.length > index
            ? controller.selectedRows[index]
            : false,
        cells: [
          DataCell(
            Text(
              order.id,
              style: Theme.of(Get.context!)
                  .textTheme
                  .bodyLarge!
                  .apply(color: TColors.primary),
            ),
          ),
          DataCell(Text(order.formattedOrderDate)),
          DataCell(
            Text('${order.items.length} items'),
          ),
          DataCell(
            TRoundedContainer(
              radius: TSizes.cardRadiusSm,
              padding: const EdgeInsets.symmetric(
                  horizontal: TSizes.md, vertical: TSizes.sm),
              backgroundColor:
                  THelperFunctions.getOrderStatusColor(order.status)
                      .withOpacity(0.1),
              child: Text(
                order.status.name.capitalize.toString(),
                style: TextStyle(
                    color: THelperFunctions.getOrderStatusColor(order.status)),
              ),
            ),
          ),
          DataCell(Text('\$${order.totalAmount}')),
          // DataCell(
          //   TTableActionButtons(
          //     view: true,
          //     edit: false,
          //     onViewPressed: () => Get.toNamed(TRoutes.customerDetails,
          //         arguments: UserModel.empty()),
          //     onDeletePressed: () {},
          //   ),
          // )
        ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => controller.allCustomerOrders.length;

  @override
  int get selectedRowCount =>
      controller.selectedRows.where((element) => element).length;
}
