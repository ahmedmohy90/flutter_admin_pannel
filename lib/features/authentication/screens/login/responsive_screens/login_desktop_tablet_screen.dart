import 'package:admin_pannel/common/widgets/layout/templates/login_template.dart';
import 'package:admin_pannel/features/authentication/screens/login/widgets/login_form_widget.dart';
import 'package:admin_pannel/features/authentication/screens/login/widgets/login_header_widget.dart';
import 'package:flutter/material.dart';

class LoginDesktopTabletScreen extends StatelessWidget {
  const LoginDesktopTabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        width: 550,
        child: SingleChildScrollView(
            child: TLoginTemplate(
          child: Column(children: [
            // Header
            LoginHeaderWidget(),
            LoginFormWidget()
          ]),
        )),
      ),
    );
  }
}
