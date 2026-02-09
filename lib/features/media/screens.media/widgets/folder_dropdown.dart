import 'package:admin_pannel/features/media/controllers/media_controller.dart';
import 'package:admin_pannel/utils/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MediaFolderDropDown extends StatelessWidget {
  const MediaFolderDropDown({super.key, this.onChange});

  final void Function(MediaCategory?)? onChange;
  @override
  Widget build(BuildContext context) {
    final controller = MediaController.instance;
    return SizedBox(
      width: 140,
      child: DropdownButtonFormField(
          isExpanded: false,
          value: controller.selectedPath.value,
          items: MediaCategory.values
              .map((category) => DropdownMenuItem(
                  value: category,
                  child: Text(category.name.capitalize.toString())))
              .toList(),
          onChanged: onChange),
    );
  }
}
