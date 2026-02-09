import 'package:admin_pannel/common/widgets/layout/templates/site_layout.dart';
import 'package:admin_pannel/features/shop/screens/order/order_details/responsive_screens/order_details_desktop_screen.dart';
import 'package:admin_pannel/features/shop/screens/order/order_details/responsive_screens/orders_details_mobile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'responsive_screens/orders_details_tablet_screen.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key});

  

  @override
  Widget build(BuildContext context) {
    final order = Get.arguments;
    final orderId = Get.parameters['orderId'];
    return TSiteTemplate(
      desktop: OrderDetailsDesktopScreen(order: order),
      tablet: OrderDetailsTabletScreen(order: order),
      mobile: OrderDetailsMobileScreen(order: order),
    );
  }
}
