import 'package:admin_pannel/common/widgets/layout/templates/site_layout.dart';
import 'package:flutter/material.dart';

import 'responsive_screens/desktop_dashboard_screen.dart';
import 'responsive_screens/mobile_dashboard_screen.dart';
import 'responsive_screens/tablet_dashboard_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TSiteTemplate(
      desktop: DesktopDashboardScreen(),
      tablet: TabletDashboardScreen(),
      mobile: MobileDashboardScreen(),
    );
  }
}
