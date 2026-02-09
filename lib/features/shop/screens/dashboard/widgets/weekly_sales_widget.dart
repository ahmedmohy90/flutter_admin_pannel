import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/device/device_utility.dart';
import '../../../controllers/dashboard/dashboard_controller.dart';

class TWeeklySalesWidget extends StatelessWidget {
  const TWeeklySalesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DashboardController());

    return TRoundedContainer(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          'weekly Sales',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(
          height: TSizes.spaceBtwSections,
        ),
        // Bar chart
        SizedBox(
          height: 350,
          child: BarChart(
            BarChartData(
                titlesData: buildFlTitlesData(),
                borderData: FlBorderData(
                  show: true,
                  border: Border(top: BorderSide.none, right: BorderSide.none),
                ),
                gridData: FlGridData(
                  show: true,
                  drawHorizontalLine: true,
                  drawVerticalLine: false,
                  horizontalInterval: 200,
                ),
                barGroups: controller.weeklySales
                    .asMap()
                    .entries
                    .map((entry) => BarChartGroupData(x: entry.key, barRods: [
                          BarChartRodData(
                              toY: entry.value,
                              color: TColors.primary,
                              borderRadius: BorderRadius.circular(TSizes.sm))
                        ]))
                    .toList(),
                groupsSpace: TSizes.spaceBtwItems,
                barTouchData: BarTouchData(
                    touchTooltipData: BarTouchTooltipData(
                      getTooltipColor: (_) => TColors.secondary,
                    ),
                    touchCallback: TDeviceUtils.isDesktopScreen(context)
                        ? (barTouchEvent, barTouchResponse) {}
                        : null)),
          ),
        )
      ]),
    );
  }

  FlTitlesData buildFlTitlesData() {
    return FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: (value, meta) {
              final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
              final index = value.toInt() % days.length;
              final day = days[index];
              return SideTitleWidget(
                  axisSide: AxisSide.bottom, space: 0, child: Text(day));
            },
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 200,
            reservedSize: 50,
          ),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ));
  }
}
