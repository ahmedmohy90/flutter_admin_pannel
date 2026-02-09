import 'package:admin_pannel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:admin_pannel/features/shop/models/banner_model.dart';
import 'package:flutter/material.dart';

import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../widgets/edit_banner_form.dart';

class EditBannerDesktopScreen extends StatelessWidget {
  const EditBannerDesktopScreen({super.key, required this.banner});

  final BannerModel? banner;
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
              heading: 'Update Banner',
              breadcumbsItems: [TRoutes.banners, 'Update Banner'],
              returnToPreviousScreen: true,
            ),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),
            EditBannerForm(banner: banner!)
          ],
        ),
      )),
    );
  }
}
