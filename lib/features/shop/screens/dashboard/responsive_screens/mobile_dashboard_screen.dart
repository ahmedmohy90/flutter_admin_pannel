import 'package:flutter/material.dart';

import '../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../utils/constants/sizes.dart';
import '../tables/dashboard_order_table.dart';
import '../widgets/dashboard_card.dart';
import '../widgets/order_status_graph.dart';
import '../widgets/weekly_sales_widget.dart';

class MobileDashboardScreen extends StatelessWidget {
  const MobileDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
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
              // Cards
              TDashboardCard(
                stats: 25,
                title: 'Sales Total',
                subTitle: '\$365.6',
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              TDashboardCard(
                stats: 25,
                title: 'Sales Total',
                subTitle: '\$365.6',
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              TDashboardCard(
                stats: 25,
                title: 'Sales Total',
                subTitle: '\$365.6',
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              TDashboardCard(
                stats: 25,
                title: 'Sales Total',
                subTitle: '\$365.6',
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              const TWeeklySalesWidget(),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              TRoundedContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order Status',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwSections,
                    ),
                    const DashboardOrderTable()
                  ],
                ),
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              const OrderStatusPieChart()
            ],
          ),
        ),
      ),
    );
  }
}
