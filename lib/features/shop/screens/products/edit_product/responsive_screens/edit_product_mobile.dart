import 'package:admin_pannel/features/shop/models/product_model.dart';
import 'package:admin_pannel/features/shop/screens/products/edit_product/widgets/additional_images.dart';
import 'package:admin_pannel/features/shop/screens/products/edit_product/widgets/attributes_widget.dart';
import 'package:admin_pannel/features/shop/screens/products/edit_product/widgets/brand_widget.dart';
import 'package:admin_pannel/features/shop/screens/products/edit_product/widgets/categories_widget.dart';
import 'package:admin_pannel/features/shop/screens/products/edit_product/widgets/product_type_widget.dart';
import 'package:admin_pannel/features/shop/screens/products/edit_product/widgets/stock_pricing_widget.dart';
import 'package:admin_pannel/features/shop/screens/products/edit_product/widgets/thumbnail_widget.dart';
import 'package:admin_pannel/features/shop/screens/products/edit_product/widgets/title_description.dart';
import 'package:admin_pannel/features/shop/screens/products/edit_product/widgets/variations_widget.dart';
import 'package:admin_pannel/features/shop/screens/products/edit_product/widgets/visibility_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../controllers/product/edit_product_controller.dart';
import '../../../../controllers/product/product_images_controller.dart';
import '../widgets/bottom_navigation_widget.dart';

class EditBrandMobileScreen extends StatelessWidget {
  const EditBrandMobileScreen({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
     final controller = ProductImagesController.instance;
    final editController = Get.put(EditProductController());
    editController.initProductData(product);
    return Scaffold(
     bottomNavigationBar: ProductBottomNavigationButtons(product: product),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // BreadCrumbs
            const TBreadcrumbsWithHeading(
                returnToPreviousScreen: true,
                heading: 'Edit Product',
                breadcumbsItems: [TRoutes.products, 'Edit Product']),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),
            // Create Product
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ProductTitleAndDescription(),
                const SizedBox(
                  height: TSizes.spaceBtwSections,
                ),
                TRoundedContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Stock & Pricing',
                          style: Theme.of(context).textTheme.headlineSmall),
                      const SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),
                       const ProductTypeWidget(),
                      const SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),
                      const ProductStockAndPricing(),
                      const SizedBox(
                        height: TSizes.spaceBtwSections,
                      ),
                      const ProductAttributes(),
                      const SizedBox(
                        height: TSizes.spaceBtwSections,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: TSizes.spaceBtwSections,
                ),
                const ProductVariations(),

                const SizedBox(
                  width: TSizes.spaceBtwSections,
                ),

                const ProductThumbnailImage(),
                const SizedBox(
                  height: TSizes.spaceBtwSections,
                ),
                //  Product Images
                TRoundedContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'All Product Images',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),
                     ProductAdditionalImages(
                              additionalProductImagesURLs:
                                  controller.additionalProductImagesUrls,
                              onTapToAddImages: () =>
                                  controller.selectMultipleProductImages(),
                              onTapToRemoveImages: (index) =>
                                  controller.removeImage(index),
                            ),
                      const SizedBox(
                        height: TSizes.spaceBtwSections,
                      ),
                      // pRODUCT bRAND
                      const ProductBrand(),
                      const SizedBox(
                        height: TSizes.spaceBtwSections,
                      ),
                      // Product categories
                       ProductCategories(product: product,),
                      const SizedBox(
                        height: TSizes.spaceBtwSections,
                      ),
                      // Product visibility
                      const ProductVisibilityWidget(),
                      const SizedBox(
                        height: TSizes.spaceBtwSections,
                      ),
                    ],
                  ),
                ),

                // CreateProductForm()
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
