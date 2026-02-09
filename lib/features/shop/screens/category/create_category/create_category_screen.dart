import 'package:admin_pannel/common/widgets/layout/templates/site_layout.dart';
import 'package:flutter/material.dart';

import 'responsive_screens/create_category_desktop.dart';

class CreateCategoryScreen extends StatelessWidget {
  const CreateCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TSiteTemplate(
      desktop: const CreateCategoryDesktopScreen(),
      tablet: const Placeholder(),
      mobile: const Placeholder(),
    );
  }
}
