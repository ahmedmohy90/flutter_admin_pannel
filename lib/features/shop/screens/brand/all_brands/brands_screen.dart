import 'package:admin_pannel/common/widgets/layout/templates/site_layout.dart';
import 'package:flutter/material.dart';

import 'responsive_screens/brands_desktop.dart';
import 'responsive_screens/brands_mobile.dart';
import 'responsive_screens/brands_tablet.dart';

class BrandsScreen extends StatelessWidget {
  const BrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TSiteTemplate(
      desktop: BrandsDesktopScreen(),
      tablet: BrandsDesktopScreen(),
      mobile: BrandsDesktopScreen(),
    );
  }
}
