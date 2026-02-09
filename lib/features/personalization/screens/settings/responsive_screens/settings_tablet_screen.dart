import 'package:flutter/material.dart';

import '../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../utils/constants/sizes.dart';
import '../widgets/settings_form.dart';
import '../widgets/image_meta.dart';

class SettingsTabletScreen extends StatelessWidget {
  const SettingsTabletScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TBreadcrumbsWithHeading(
                heading: 'Profile', breadcumbsItems: ['Profile']),
            SizedBox(
              height: TSizes.spaceBtwSections,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ImageAndMeta(),
                SizedBox(
                  width: TSizes.spaceBtwSections,
                ),
                SettingsForm()
              ],
            )
          ],
        ),
      ),
    ));
  }
}
