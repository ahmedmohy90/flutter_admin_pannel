import 'package:admin_pannel/common/widgets/layout/templates/site_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/product/edit_product_controller.dart';
import 'responsive_screens/edit_product_desktop.dart';
import 'responsive_screens/edit_product_mobile.dart';

class EditProductScreen extends StatelessWidget {
  const EditProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditProductController());
    final product = Get.arguments;
    return TSiteTemplate(
      desktop: EditBrandDesktopScreen(
        product: product,
      ),
      mobile: EditBrandMobileScreen(
        product: product,
      ),
    );
  }
}
