import 'package:admin_pannel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:flutter/material.dart';

import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../widgets/create_banner_form.dart';

class CreateBannerdDesktopScreen extends StatelessWidget {
  const CreateBannerdDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // BreadCrumbs
            TBreadcrumbsWithHeading(
                returnToPreviousScreen: true,
                heading: 'Create Banner',
                breadcumbsItems: [TRoutes.banners, 'Create Banner']),
            SizedBox(
              height: TSizes.spaceBtwSections,
            ),
            CreateBannerForm()
          ],
        ),
      )),
    );
  }
}
