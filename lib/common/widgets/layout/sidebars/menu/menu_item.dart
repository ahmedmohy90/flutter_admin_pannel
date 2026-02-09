import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../sidebar_controller.dart';

class TMenuItem extends StatelessWidget {
  const TMenuItem(
      {super.key,
      required this.route,
      required this.icon,
      required this.iconName});

  final String route;
  final IconData icon;
  final String iconName;
  @override
  Widget build(BuildContext context) {
    final menuController = Get.put(SidebarController());
    return InkWell(
      onTap: () => menuController.menuOnTap(route),
      onHover: (hovaring) => hovaring
          ? menuController.changeHoverItem(route)
          : menuController.changeHoverItem(''),
      child: Obx(
        () {
          final isActive = menuController.isActive(route);
          final isHover = menuController.isHovaring(route);

          return Container(
            margin: const EdgeInsets.symmetric(vertical: TSizes.xs),
            decoration: BoxDecoration(
              color: isActive || isHover ? TColors.primary : Colors.transparent,
              borderRadius: BorderRadius.circular(TSizes.cardRadiusMd),
              border: Border(
                right: BorderSide(
                  color: isActive ? TColors.primary : TColors.grey,
                  width: 1.0,
                ),
              ),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(TSizes.md),
                  child: Icon(
                    icon,
                    color:
                        isActive || isHover ? TColors.white : TColors.darkGrey,
                  ),
                ),
                Flexible(
                  child: Text(
                    iconName,
                    style: Theme.of(context).textTheme.bodyMedium!.apply(
                          color: isActive || isHover
                              ? TColors.white
                              : TColors.darkGrey,
                        ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
