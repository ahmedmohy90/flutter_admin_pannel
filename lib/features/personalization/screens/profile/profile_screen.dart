import 'package:admin_pannel/common/widgets/layout/templates/site_layout.dart';
import 'package:flutter/material.dart';

import 'responsive_screens/profile_desktop_screen.dart';
import 'responsive_screens/profile_mobile_screen.dart';
import 'responsive_screens/profile_tablet_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TSiteTemplate(
        desktop: ProfileDesktopScreen(),
        tablet: ProfileTabletScreen(),
        mobile: ProfileMobileScreen());
  }
}
