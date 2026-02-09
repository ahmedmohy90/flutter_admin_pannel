import 'package:admin_pannel/common/widgets/layout/templates/site_layout.dart';
import 'package:admin_pannel/features/shop/screens/brand/create_brand/responsive_screens/create_banner_mobile.dart';
import 'package:admin_pannel/features/shop/screens/brand/create_brand/responsive_screens/create_banner_tablet.dart';
import 'package:flutter/material.dart';

import 'responsive_screens/create_banner_desktop.dart';

class CreateBrandScreen extends StatelessWidget {
  const CreateBrandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TSiteTemplate(
      desktop: CreateBrandDesktopScreen(),
      tablet: CreateBrandTabletScreen(),
      mobile: CreateBrandMobileScreen(),
    );
  }
}
