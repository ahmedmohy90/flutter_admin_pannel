import 'package:admin_pannel/common/widgets/layout/templates/site_layout.dart';
import 'package:admin_pannel/features/shop/screens/order/all_orders/responsive_screens/orders_desktop_screen.dart';
import 'package:admin_pannel/features/shop/screens/order/all_orders/responsive_screens/orders_mobile_screen.dart';
import 'package:admin_pannel/features/shop/screens/order/all_orders/responsive_screens/orders_tablet_screen.dart';
import 'package:flutter/material.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TSiteTemplate(
      desktop: OrdersDesktopScreen(),
      tablet: OrdersTabletScreen(),
      mobile: OrdersMobileScreen(),
    );
  }
}
