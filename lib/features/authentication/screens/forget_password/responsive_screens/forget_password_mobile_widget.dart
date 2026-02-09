import 'package:admin_pannel/features/authentication/screens/forget_password/widgets/forget_password_header_form_widget.dart';
import 'package:admin_pannel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class ForgetPasswordMobileWidget extends StatelessWidget {
  const ForgetPasswordMobileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: ForgetPasswordHeaderFormWidget(),
        ),
      ),
    );
  }
}
