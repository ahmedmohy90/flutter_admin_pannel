import 'package:admin_pannel/common/widgets/layout/templates/site_layout.dart';
import 'package:admin_pannel/features/shop/screens/category/edit_category/responsive_screens/edit_categories_mobile.dart';
import 'package:admin_pannel/features/shop/screens/category/edit_category/responsive_screens/edit_categories_tablet.dart';
import 'package:admin_pannel/features/shop/screens/category/edit_category/responsive_screens/edit_category_desktop.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/category_model.dart';

class EditCategoryScreen extends StatelessWidget {
  const EditCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final category = Get.arguments;
    return TSiteTemplate(
      desktop: EditCategoryDesktopScreen(
        category: category,
      ),
      tablet: EditCategoriesTabletScreen(
        category: category,
      ),
      mobile: EditCategoriesMobileScreen(
        category: category,
      ),
    );
  }
}
