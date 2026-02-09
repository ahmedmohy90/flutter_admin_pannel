import 'package:admin_pannel/common/widgets/layout/templates/site_layout.dart';
import 'package:admin_pannel/features/shop/models/banner_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/brand_model.dart';
import 'responsive_screens/edit_banner_desktop.dart';
import 'responsive_screens/edit_banner_mobile.dart';
import 'responsive_screens/edit_banner_tablet.dart';

class EditBannerScreen extends StatelessWidget {
  const EditBannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final banner =  Get.arguments;
    return TSiteTemplate(
      desktop: EditBannerDesktopScreen(
        banner: banner,
      ),
      tablet: EditBannerTabletScreen(
        banner: banner,
      ),
      mobile: EditBannerMobileScreen(
        banner: banner,
      ),
    );
  }
}
