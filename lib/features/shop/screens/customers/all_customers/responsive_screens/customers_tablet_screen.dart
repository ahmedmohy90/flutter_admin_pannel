import 'package:flutter/material.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../common/widgets/data_table/table_header.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../tables/data_table.dart';

class CustomersTabletScreen extends StatelessWidget {
  const CustomersTabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TBreadcrumbsWithHeading(
                heading: 'Customers', breadcumbsItems: ['Customers']),
            SizedBox(
              height: TSizes.spaceBtwSections,
            ),
            TRoundedContainer(
              child: Column(children: [
                TTableHeaderWidget(
                  showLeftWidget: false,
                ),
                SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                CustomersTable()
              ]),
            )
          ],
        ),
      ),
    ));
  }
}