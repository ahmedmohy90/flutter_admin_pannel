import 'package:admin_pannel/routes/routes.dart';
import 'package:admin_pannel/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TTableHeaderWidget extends StatelessWidget {
  const TTableHeaderWidget(
      {super.key,
      this.onPressed,
      this.buttonText,
      this.searchController,
      this.searchOnChange,
      this.showLeftWidget = true});
  final Function()? onPressed;
  final String? buttonText;

  final bool showLeftWidget;
  final TextEditingController? searchController;
  final Function(String)? searchOnChange;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: TDeviceUtils.isDesktopScreen(context) ? 3 : 1,
          child: showLeftWidget
              ? Row(
                  children: [
                    SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        onPressed: onPressed,
                        child: Text(buttonText!),
                      ),
                    ),
                  ],
                )
              : const SizedBox.shrink(),
        ),
        Expanded(
            flex: TDeviceUtils.isDesktopScreen(context) ? 2 : 1,
            child: TextFormField(
                controller: searchController,
                onChanged: (value) => searchOnChange!(value),
                decoration: const InputDecoration(
                  prefixIcon: Icon(Iconsax.search_normal),
                  hintText: 'Search...',
                )))
      ],
    );
  }
}
