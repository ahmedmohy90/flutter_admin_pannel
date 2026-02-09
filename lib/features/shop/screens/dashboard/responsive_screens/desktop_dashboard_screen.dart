import 'package:admin_pannel/common/widgets/containers/rounded_container.dart';
import 'package:admin_pannel/features/shop/screens/dashboard/tables/dashboard_order_table.dart';
import 'package:admin_pannel/features/shop/screens/dashboard/widgets/weekly_sales_widget.dart';
import 'package:admin_pannel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/product/product_images_controller.dart';
import '../widgets/dashboard_card.dart';
import '../widgets/order_status_graph.dart';

class DesktopDashboardScreen extends StatelessWidget {
  const DesktopDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final prodController = Get.put(ProductImagesController());

    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(30.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Dashboard',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),
            ElevatedButton(
                onPressed: () => prodController.selectThumbnailImage(),
                child: const Text('Select Single Image')),

            ElevatedButton(
                onPressed: () => prodController.selectMultipleProductImages(),
                child: const Text('Select Multiple Image')),

            // Cards
            Row(
              children: [
                Expanded(
                  child: TDashboardCard(
                    stats: 25,
                    title: 'Sales Total',
                    subTitle: '\$365.6',
                  ),
                ),
                const SizedBox(
                  width: TSizes.spaceBtwItems,
                ),
                Expanded(
                  child: TDashboardCard(
                    stats: 25,
                    title: 'Sales Total',
                    subTitle: '\$365.6',
                  ),
                ),
                const SizedBox(
                  width: TSizes.spaceBtwItems,
                ),
                Expanded(
                  child: TDashboardCard(
                    stats: 25,
                    title: 'Sales Total',
                    subTitle: '\$365.6',
                  ),
                ),
                const SizedBox(
                  width: TSizes.spaceBtwItems,
                ),
                Expanded(
                  child: TDashboardCard(
                    stats: 25,
                    title: 'Sales Total',
                    subTitle: '\$365.6',
                  ),
                ),
              ],
            ),
            // GRAPHS

            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      // BAR GRAPH
                      const TWeeklySalesWidget(),
                      const SizedBox(
                        height: TSizes.spaceBtwSections,
                      ),
                      // Orders
                      TRoundedContainer(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Recent Orders',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            const SizedBox(
                              height: TSizes.spaceBtwSections,
                            ),
                            const DashboardOrderTable()
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: TSizes.spaceBtwSections,
                ),
                // Pic chart
                Expanded(
                  child: OrderStatusPieChart(),
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
