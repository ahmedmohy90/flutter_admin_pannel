import 'package:admin_pannel/common/widgets/containers/circular_container.dart';
import 'package:admin_pannel/common/widgets/containers/rounded_container.dart';
import 'package:admin_pannel/features/shop/controllers/dashboard/dashboard_controller.dart';
import 'package:admin_pannel/utils/helpers/helper_functions.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/constants/enums.dart';
import '../../../../../utils/constants/sizes.dart';

class OrderStatusPieChart extends StatelessWidget {
  const OrderStatusPieChart({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = DashboardController.instance;
    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Status',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(
            height: TSizes.spaceBtwSections,
          ),
          SizedBox(
            height: 350,
            child: PieChart(
              PieChartData(
                sections: controller.orderStatusData.entries.map(
                  (entry) {
                    return PieChartSectionData(
                      value: entry.value.toDouble(),
                      title: '${entry.value}',
                      titleStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      radius: 100,
                      color: THelperFunctions.getOrderStatusColor(entry.key),
                    );
                  },
                ).toList(),
                pieTouchData: PieTouchData(
                  touchCallback: (FlTouchEvent event, pieTouchResponse) {},
                  enabled: true,
                ),
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: DataTable(
              columns: const [
                DataColumn(label: Text('Status')),
                DataColumn(label: Text('Orders')),
                DataColumn(label: Text('Total')),
              ],
              rows: controller.orderStatusData.entries.map((entry) {
                final OrderStatus status = entry.key;
                final int conut = entry.value;
                final double totalAmount = controller.totalAmounts[status] ?? 0;
                return DataRow(cells: [
                  DataCell(Row(
                    children: [
                      TCircularContainer(
                        width: 20,
                        height: 20,
                        backgroundColor:
                            THelperFunctions.getOrderStatusColor(status),
                      ),
                      SizedBox(
                        width: TSizes.spaceBtwInputFields,
                      ),
                      Expanded(
                        child: Text(status.name),
                      ),
                    ],
                  )),
                  DataCell(Text(conut.toString())),
                  DataCell(Text('\$${totalAmount.toStringAsFixed(2)}')),
                ]);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
