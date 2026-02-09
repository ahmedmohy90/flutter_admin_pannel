import 'package:admin_pannel/data/repositores/product/product_repository.dart';
import 'package:admin_pannel/features/shop/controllers/product/product_images_controller.dart';
import 'package:admin_pannel/features/shop/controllers/product/products_controller.dart';
import 'package:admin_pannel/features/shop/controllers/product/variation_controller.dart';
import 'package:admin_pannel/features/shop/models/brand_model.dart';
import 'package:admin_pannel/features/shop/models/category_model.dart';
import 'package:admin_pannel/features/shop/screens/products/create_product/widgets/attributes_widget.dart';
import 'package:admin_pannel/utils/constants/image_strings.dart';
import 'package:admin_pannel/utils/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/enums.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/loaders.dart';
import '../../models/product_category_model.dart';
import '../../models/product_model.dart';
import 'attributes_controller.dart';

class CreateProductController extends GetxController {
  static CreateProductController get instance => Get.find();

  // Observables for loading state and product details

  final isLoading = false.obs;
  final productType = ProductType.single.obs;

  final productVisibility = ProductVisibility.hidden.obs;

  //  controllers and keys

  final stockPriceFormKey = GlobalKey<FormState>();
  final productRepository = Get.put(ProductRepository());
  final titleDescreptionFormKey = GlobalKey<FormState>();

  //  Text editing controllers for input fields
  TextEditingController productTitleController = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  TextEditingController productStockController = TextEditingController();
  TextEditingController productSalesPriceController = TextEditingController();
  TextEditingController productBrandController = TextEditingController();

  // Rx observables for product details
  final Rx<BrandModel?> selectedBrand = Rx<BrandModel?>(null);

  final RxList<CategoryModel> selectedCategories = <CategoryModel>[].obs;

  RxBool thumbnailUploader = false.obs;
  RxBool additionalImagesUploader = false.obs;
  RxBool productDataUploader = false.obs;
  RxBool categoriesRelationshipUploader = false.obs;

  Future<void> createProduct() async {
    try {
      // showProgressDialog();
      TFullScreenLoader.openLoadingDialog(
          'Creating Product...', TImages.docerAnimation);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // validate title and descripton
      if (!titleDescreptionFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }
      // validate stock and price
      if (productType.value == ProductType.single &&
          !stockPriceFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }
      if (selectedBrand.value == null) throw 'Select Brand for this product';
      //  check varation data if ProductType = variable
      if (productType.value == ProductType.variable &&
          ProductVariationController.instance.productVariations.isEmpty) {
        throw 'There are no variations for the Product Type variable. create some variation or change product type.';
      }
      Get.put(ProductVariationController());
      if (productType.value == ProductType.variable) {
        final variationCheckFailed = ProductVariationController
            .instance.productVariations
            .any((element) =>
                element.price.isNaN ||
                element.price < 0 ||
                element.salePrice.isNaN ||
                element.salePrice < 0 ||
                element.stock.isNaN ||
                element.stock < 0 ||
                element.image.value.isEmpty);

        if (variationCheckFailed) {
          throw 'Variation data is not accurate, please check and try again.';
        }
      }
      // upload product thumbnail image
      thumbnailUploader.value = true;
      final imageController = ProductImagesController.instance;
      if (imageController.selectedThumbnailImageUrl.value == null) {
        throw 'Select product thumbnail image';
      }
      //  additional product images
      additionalImagesUploader.value = true;

      // product variation images
      final variations = ProductVariationController.instance.productVariations;
      if (productType.value == ProductType.single && variations.isNotEmpty) {
        ProductVariationController.instance.resetAllValues();
        variations.value = [];
      }
      final newRecord = ProductModel(
        id: '',
        stock: int.tryParse(productStockController.text.trim()) ?? 0,
        sku: '',
        price: double.tryParse(productPriceController.text.trim()) ?? 0.0,
        title: productTitleController.text,
        date: DateTime.now(),
        salePrice:
            double.tryParse(productSalesPriceController.text.trim()) ?? 0.0,
        thumbnail: imageController.selectedThumbnailImageUrl.value ?? '',
        isFeatured: true,
        brand: selectedBrand.value,
        // categoryId: selectedCategories.first.id,
        productType: productType.value.toString(),
        description: productDescriptionController.text.trim(),
        images: imageController.additionalProductImagesUrls,
        // soldQuantity: 0,
        attributes: ProductAttributesController.instance.productAttributes,
        variations: variations,
      );

      // call repositoty to create product
      productDataUploader.value = true;
      newRecord.id = await productRepository.createProduct(newRecord);

      //  register product categories relationship
      if (selectedCategories.isNotEmpty) {
        if (newRecord.id.isEmpty) {
          throw 'Error storing data, try again';
        }

        //  loop through selected Product categories
        categoriesRelationshipUploader.value = true;
        for (var category in selectedCategories) {
          final prodCategory = ProductCategoryModel(
            productId: newRecord.id,
            categoryId: category.id,
          );
          await ProductRepository.instance.createProductCategory(prodCategory);
        }
      }

      //  upload product list
      Get.put(ProductsController());
      ProductsController.instance.addItemToList(newRecord);

      TFullScreenLoader.stopLoading();

      showCompletionDialog();
    } catch (e) {
      TFullScreenLoader.stopLoading();
    }
  }

  void showCompletionDialog() {
    Get.dialog(AlertDialog(
      title: const Text('Conguratulations'),
      actions: [
        TextButton(
            onPressed: () {
              Get.back();
              Get.back();
            },
            child: const Text('Go to Products'))
      ],
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            TImages.productsIllustration,
            height: 200,
            width: 200,
          ),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),
          Text('Congratulations',
              style: Theme.of(Get.context!).textTheme.headlineSmall),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),
          Text('Product created successfully',
              style: Theme.of(Get.context!).textTheme.bodyMedium),
        ],
      ),
    ));
  }

  void resetValues() {
    isLoading.value = false;
    productType.value = ProductType.single;
    productVisibility.value = ProductVisibility.hidden;
    stockPriceFormKey.currentState!.reset();
    titleDescreptionFormKey.currentState!.reset();
    productTitleController.text = '';
    productDescriptionController.text = '';
    productPriceController.text = '';
    productSalesPriceController.text = '';
    productStockController.text = '';
    productBrandController.text = '';

    selectedCategories.clear();
    selectedBrand.value = null;

    ProductVariationController.instance.resetAllValues();
    ProductAttributesController.instance.resetProductAttributes();

    thumbnailUploader.value = false;
    additionalImagesUploader.value = false;
    productDataUploader.value = false;
    categoriesRelationshipUploader.value = false;
  }
  // void showProgressDialog() {
  //   showDialog(context: Get.context!, builder: (contex)=>
  //     PopScope(
  //       canPop: false,
  //       child:
  //         AlertDialog(
  //         content:   Obx(
  //             () => Column(
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //               Image.asset(TImages.creatingProductIllustration,height: 200,width: 200,),
  //               const SizedBox(height: TSizes.spaceBtwItems,),
  //               buildCheckbox('Thumbnail Image', thumbnailUploader),
  //               buildCheckbox('additional Images', additionalImagesUploader),
  //               buildCheckbox('Product Data, attributes and variations', productDataUploader),
  //               buildCheckbox('Product Categories', categoriesRelationshipUploader),

  //               ],  )

  //           )
  //         )
  //     )
  //   );

  // }
}
