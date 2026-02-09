import 'package:admin_pannel/common/widgets/layout/templates/site_layout.dart';
import 'package:flutter/material.dart';

import 'responsive_screens/products_desktop.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    return const TSiteTemplate(
      desktop: ProductsDesktopScreen(),
      tablet: ProductsDesktopScreen(),
      mobile: ProductsDesktopScreen(),
    );
  }
}
