import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../widgets/additional_images.dart';
import '../widgets/attributes_widget.dart';
import '../widgets/brand_widget.dart';
import '../widgets/categories_widget.dart';
import '../widgets/create_product_form.dart';
import '../widgets/product_type_widget.dart';
import '../widgets/stock_pricing_widget.dart';
import '../widgets/thumbnail_widget.dart';
import '../widgets/title_description.dart';
import '../widgets/variations_widget.dart';
import '../widgets/visibility_widget.dart';

class CreateProductMobileScreen extends StatelessWidget {
  const CreateProductMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: const ProductBottomNavigationButtons(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // BreadCrumbs
            const TBreadcrumbsWithHeading(
                returnToPreviousScreen: true,
                heading: 'Create Product',
                breadcumbsItems: [TRoutes.products, 'Create Product']),
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
                        additionalProductImagesURLs: RxList<String>.empty(),
                        onTapToAddImages: () {},
                        onTapToRemoveImages: (index) {},
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
                      const ProductCategories(),
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
