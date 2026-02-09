import 'package:admin_pannel/common/widgets/layout/templates/site_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'responsive_screens/customer_details_desktop_screen.dart';
import 'responsive_screens/customer_details_mobile_screen.dart';
import 'responsive_screens/customers_details_tablet_screen.dart';

class CustomerDetailsScreen extends StatelessWidget {
  const CustomerDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final customer = Get.arguments;
    final customerId = Get.parameters['customerId'];
    return TSiteTemplate(
      desktop: CustomerDetailsDesktopScreen(customer: customer),
      tablet: CustomerDetailsTabletScreen(customer: customer),
      mobile: CustomerDetailsMobileScreen(customer: customer),
    );
  }
}
