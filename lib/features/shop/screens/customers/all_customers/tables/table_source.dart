import 'package:admin_pannel/common/widgets/images/t_rounded_image.dart';
import 'package:admin_pannel/features/authentication/models/user_model.dart';
import 'package:admin_pannel/utils/constants/colors.dart';
import 'package:admin_pannel/utils/constants/enums.dart';
import 'package:admin_pannel/utils/constants/image_strings.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/widgets/icons/table_action_icon_buttons.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../controllers/customer/customer_controller.dart';

class CustomerRows extends DataTableSource {
  final contoller = CustomerController.instance;
  @override
  DataRow? getRow(int index) {
    final customer = contoller.filteredItems[index];
    return DataRow2(
        onTap: () => Get.toNamed(TRoutes.customerDetails,
            arguments: customer, parameters: {'customerId': customer.id ?? ''}),
        selected: contoller.selectedRows[index],
        onSelectChanged: (value) =>
            contoller.selectedRows[index] = value ?? false,
        cells: [
          DataCell(Row(
            children: [
              TRoundedImage(
                width: 50,
                height: 50,
                padding: TSizes.sm,
                image: customer.profilePicture,
                imageType: ImageType.network,
                borderRadius: TSizes.borderRadiusMd,
                backgroundColor: TColors.primaryBackground,
              ),
              const SizedBox(
                width: TSizes.spaceBtwItems,
              ),
              Expanded(
                child: Text(
                  customer.fullName,
                  style: Theme.of(Get.context!)
                      .textTheme
                      .bodyLarge!
                      .apply(color: TColors.primary),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          )),
          DataCell(Text(customer.email ?? '')),
          DataCell(Text(customer.phoneNumber ?? '')),
          DataCell(
              Text(customer.createAt == null ? '' : customer.formattedData)),
          DataCell(
            TTableActionButtons(
              view: true,
              edit: false,
              onViewPressed: () =>
                  Get.toNamed(TRoutes.customerDetails, arguments: customer),
              onDeletePressed: () => contoller.confirmAndDeleteItem(customer),
            ),
          )
        ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => contoller.filteredItems.length;

  @override
  int get selectedRowCount =>
      contoller.selectedRows.where((element) => element).length;
}
