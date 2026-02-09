import 'package:admin_pannel/common/widgets/layout/templates/site_layout.dart';
import 'package:flutter/material.dart';

import 'responsive_screens/banners_desktop.dart';
import 'responsive_screens/banners_mobile.dart';
import 'responsive_screens/banners_tablet.dart';

class BannersScreen extends StatelessWidget {
  const BannersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TSiteTemplate(
      desktop: BannersDesktopScreen(),
      tablet: BannersDesktopScreen(),
      mobile: BannersDesktopScreen(),
    );
  }
}
