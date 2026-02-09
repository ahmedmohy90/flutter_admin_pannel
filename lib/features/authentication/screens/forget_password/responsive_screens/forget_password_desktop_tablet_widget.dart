import 'package:admin_pannel/common/widgets/layout/templates/login_template.dart';
import 'package:flutter/material.dart';
import '../widgets/forget_password_header_form_widget.dart';

class ForgetPasswordDesktopTabletWidget extends StatelessWidget {
  const ForgetPasswordDesktopTabletWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        width: 550,
        child: SingleChildScrollView(
          child: TLoginTemplate(
            child: ForgetPasswordHeaderFormWidget(),
          ),
        ),
      ),
    );
  }
}
