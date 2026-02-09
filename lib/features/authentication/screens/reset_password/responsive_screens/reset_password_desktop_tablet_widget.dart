import 'package:admin_pannel/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/layout/templates/login_template.dart';

import '../widgets/reset_password_widget.dart';

class ResetPasswordDesktopTabletWidget extends StatelessWidget {
  const ResetPasswordDesktopTabletWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final email = Get.arguments['email'] ?? '';
    return Center(
      child: SizedBox(
        width: 550,
        child: SingleChildScrollView(
          child: TLoginTemplate(child: ResetPasswordWidget(email: email)),
        ),
      ),
    );
  }
}
