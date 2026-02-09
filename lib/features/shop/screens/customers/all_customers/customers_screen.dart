import 'package:admin_pannel/common/widgets/layout/templates/site_layout.dart';
import 'package:flutter/material.dart';

import 'responsive_screens/customers_desktop_screen.dart';
import 'responsive_screens/customers_mobile_screen.dart';
import 'responsive_screens/customers_tablet_screen.dart';

class CustomersScreen extends StatelessWidget {
  const CustomersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TSiteTemplate(
      desktop: CustomersDesktopScreen(),
      tablet: CustomersTabletScreen(),
      mobile: CustomersMobileScreen(),
    );
  }
}
