import 'package:admin_pannel/features/shop/models/product_attribute_model.dart';
import 'package:admin_pannel/utils/popups/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'variation_controller.dart';

class ProductAttributesController extends GetxController {
  static ProductAttributesController get instance => Get.find();

  final isLoading = false.obs;
  final attributesFormKey = GlobalKey<FormState>();
  TextEditingController attributeName = TextEditingController();
  TextEditingController attributes = TextEditingController();
  final RxList<ProductAttributeModel> productAttributes =
      <ProductAttributeModel>[].obs;

  // function to add new attribute
  void addNewAttribute() {
    // form Validation
    if (!attributesFormKey.currentState!.validate()) return;
    productAttributes.add(ProductAttributeModel(
        name: attributeName.text.trim(),
        values: attributes.text.trim().split('|').toList()));
    attributeName.clear();
    attributes.clear();
  }

  void removeAttribute(int index, BuildContext context) {
    TDialogs.defaultDialog(context: context,
    onConfirm: () {
      Navigator.of(context).pop();
      productAttributes.removeAt(index);

      ProductVariationController.instance.productVariations.value = [];
    }
    );
  }
void resetProductAttributes(){
  productAttributes.clear();
}
}