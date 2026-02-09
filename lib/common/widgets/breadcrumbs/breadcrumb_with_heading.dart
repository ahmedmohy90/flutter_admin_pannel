import 'package:admin_pannel/common/widgets/texts/page_heading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../routes/routes.dart';
import '../../../utils/constants/sizes.dart';

class TBreadcrumbsWithHeading extends StatelessWidget {
  const TBreadcrumbsWithHeading(
      {super.key,
      required this.heading,
      required this.breadcumbsItems,
      this.returnToPreviousScreen = false});

  // the heading for the page

  final String heading;

  // list of breadcumbs items representing the navigation path
  final List<String> breadcumbsItems;

  // Flag indicating wheather to indicate  a button to return to the previous screen
  final bool returnToPreviousScreen;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      // Breadcrumb trail

      Row(
        children: [
          InkWell(
            onTap: () => Get.offAllNamed(TRoutes.dashboard),
            child: Padding(
              padding: const EdgeInsets.all(TSizes.xs),
              child: Text('Dashboard',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .apply(fontWeightDelta: -1)),
            ),
          ),
          for (int i = 0; i < breadcumbsItems.length; i++)
            Row(
              children: [
                Text('/'),
                InkWell(
                  onTap: i == breadcumbsItems.length - 1
                      ? null
                      : () => Get.offAllNamed(breadcumbsItems[i]),
                  child: Padding(
                    padding: const EdgeInsets.all(TSizes.xs),
                    child: Text(
                        i == breadcumbsItems.length - 1
                            ? breadcumbsItems[i].capitalize!.toString()
                            : capitalize(breadcumbsItems[i].substring(1)),
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .apply(fontWeightDelta: -1)),
                  ),
                ),
              ],
            ),
        ],
      ),
      const SizedBox(height: TSizes.sm),

      // heading
      Row(children: [
        if (returnToPreviousScreen)
          IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(Iconsax.arrow_left)),
        if (returnToPreviousScreen) const SizedBox(width: TSizes.xs),
        TPageHeading(heading: heading)
      ])
    ]);
  }

  String capitalize(String s) =>
      s[0].isEmpty ? '' : s[0].toUpperCase() + s.substring(1);
}
