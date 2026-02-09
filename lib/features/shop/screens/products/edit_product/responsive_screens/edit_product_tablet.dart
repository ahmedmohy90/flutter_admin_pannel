// import 'package:admin_pannel/features/shop/models/product_model.dart';
// import 'package:flutter/material.dart';

// import '../../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
// import '../../../../../../routes/routes.dart';
// import '../../../../../../utils/constants/sizes.dart';
// import '../widgets/edit_product_form.dart';

// class EditBrandTabletScreen extends StatelessWidget {
//   const EditBrandTabletScreen({super.key, required this.product});

//   final ProductModel? product;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//           child: Padding(
//         padding: const EdgeInsets.all(TSizes.defaultSpace),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const TBreadcrumbsWithHeading(
//               heading: 'Update Brand',
//               breadcumbsItems: [TRoutes.brands, 'Update Brand'],
//               returnToPreviousScreen: true,
//             ),
//             const SizedBox(
//               height: TSizes.spaceBtwSections,
//             ),
//             EditProductForm(product: product!)
//           ],
//         ),
//       )),
//     );
//   }
// }
