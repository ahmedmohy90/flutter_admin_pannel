import 'package:admin_pannel/features/authentication/screens/reset_password/widgets/reset_password_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants/sizes.dart';

class ResetPasswordMobileWidget extends StatelessWidget {
  const ResetPasswordMobileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final email = Get.arguments['email'] ?? '';
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: ResetPasswordWidget(
              email: email,
            )),
      ),
    );
  }
}
