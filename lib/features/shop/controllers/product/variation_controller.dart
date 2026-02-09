import 'package:admin_pannel/features/shop/controllers/product/attributes_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/popups/dialogs.dart';
import '../../models/product_variation_model.dart';

class ProductVariationController extends GetxController {
  static ProductVariationController instance = Get.find();

  final isLoading = false.obs;
  RxList<ProductVariationModel> productVariations =
      <ProductVariationModel>[].obs;

  List<Map<ProductVariationModel, TextEditingController>> stockControllerList =
      [];

  List<Map<ProductVariationModel, TextEditingController>> priceControllerList =
      [];

  List<Map<ProductVariationModel, TextEditingController>>
      discriptionControllerList = [];

  List<Map<ProductVariationModel, TextEditingController>>
      salePriceControllerList = [];

  final ProductAttributesController attributesController =
      Get.put(ProductAttributesController());

  void initializeVariationController(List<ProductVariationModel> variations) {
    // clear existing lists
    stockControllerList.clear();
    priceControllerList.clear();
    discriptionControllerList.clear();
    salePriceControllerList.clear();

    // initialize controllers for each variation
    for (var variation in variations) {
      //  stock controllers
      Map<ProductVariationModel, TextEditingController> stockController = {};
      stockController[variation] =
          TextEditingController(text: variation.stock.toString());
      stockControllerList.add(stockController);

      // price controllers
      Map<ProductVariationModel, TextEditingController> priceController = {};
      priceController[variation] =
          TextEditingController(text: variation.price.toString());
      priceControllerList.add(priceController);

      // discription controllers
      Map<ProductVariationModel, TextEditingController> discriptionController =
          {};
      discriptionController[variation] =
          TextEditingController(text: variation.description.toString());
      discriptionControllerList.add(discriptionController);

      // sale price controllers
      Map<ProductVariationModel, TextEditingController> salePriceController =
          {};
      salePriceController[variation] =
          TextEditingController(text: variation.salePrice.toString());
      salePriceControllerList.add(salePriceController);
    }
  }

  void removeVariations(BuildContext context) {
    TDialogs.defaultDialog(
        context: context,
        title: 'Remove variations',
        // content: 'Are you sure you want to remove all variations?',
        onConfirm: () {
          productVariations.clear();
          resetAllValues();
          Navigator.of(context).pop();
        });
  }

  void generateVariationsConfirmation(BuildContext context) {
    TDialogs.defaultDialog(
      context: context,
      confirmText: 'Generate',
      title: 'Generate variations',
      content:
          'Once the variations are created,you can not add more attributes. In order to add more variations you need to delete the existing variations first.',
      onConfirm: () => generateVariationsAttributes(),
    );
  }

  void generateVariationsAttributes() {
    Get.back();

    final List<ProductVariationModel> variations = [];

    //  CHECK IF THERE ARE ATTRIBUTES
    if (attributesController.productAttributes.isNotEmpty) {
     final List<List<String>> attributeCombinations = getCombinations(
      attributesController.productAttributes
          .map((attribute) => attribute.values
              ?.map((v) => v.toString())
              .toList() ?? [])
          .toList(),
    );

      for (final combination in attributeCombinations) {
        final Map<String, String> attributeValues = Map.fromIterables(
            attributesController.productAttributes
                .map((attr) => attr.name ?? ''),
            combination);

        final ProductVariationModel variation = ProductVariationModel(
            id: UniqueKey().toString(), attributesValues: attributeValues);
        variations.add(variation);
      
        // create controllers

        final Map<ProductVariationModel, TextEditingController> stockController =
            {};
      final Map<ProductVariationModel, TextEditingController> priceController = {};
      final Map<ProductVariationModel, TextEditingController> discriptionController = {};
      final Map<ProductVariationModel, TextEditingController> salePriceController = {};

      stockController[variation] = TextEditingController();
      priceController[variation] = TextEditingController();
      discriptionController[variation] = TextEditingController();
      salePriceController[variation] = TextEditingController();

      stockControllerList.add(stockController);
      priceControllerList.add(priceController);
      discriptionControllerList.add(discriptionController);
      salePriceControllerList.add(salePriceController);
      }
    }
        productVariations.assignAll(variations);
       
      
    

  }

  void resetAllValues() {
    productVariations.clear();
    stockControllerList.clear();
    priceControllerList.clear();
    discriptionControllerList.clear();
    salePriceControllerList.clear();
  }

  List<List<String>> getCombinations(List<List<String>?> lists) {
    final List<List<String>> result = [];

    combine(lists, 0, <String>[], result);

    return result;
  }

  void combine(List<List<String>?> lists, int index, List<String> current,
      List<List<String>> result) {
    if (index == lists!.length) {
      result.add(current);
      return;
    }

    for (final item in lists[index] ?? []) {
      final List<String> update = List.from(current);
      update.add(item);
      combine(lists, index + 1, update, result);
    }
  }
}
