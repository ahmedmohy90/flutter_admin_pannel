import 'package:admin_pannel/common/widgets/layout/templates/site_layout.dart';
import 'package:flutter/material.dart';

import 'responsive_screens/settings_desktop_screen.dart';
import 'responsive_screens/settings_mobile_screen.dart';
import 'responsive_screens/settings_tablet_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TSiteTemplate(
        desktop: SettingsDesktopScreen(),
        tablet: SettingsTabletScreen(),
        mobile: SettingsMobileScreen());
  }
}
