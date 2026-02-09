import 'package:flutter/material.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../models/category_model.dart';
import '../widgets/edit_category_form.dart';

class EditCategoriesMobileScreen extends StatelessWidget {
  const EditCategoriesMobileScreen({super.key, required this.category});

  final CategoryModel? category;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TBreadcrumbsWithHeading(
              heading: 'Update Category',
              breadcumbsItems: [TRoutes.categories, 'Update Category'],
              returnToPreviousScreen: true,
            ),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),
            EditCategoryForm(category: category!)
          ],
        ),
      )),
    );
  }
}
