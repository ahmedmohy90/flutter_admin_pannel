import 'package:flutter/material.dart';

import '../../../../../utils/constants/sizes.dart';
import '../widgets/login_form_widget.dart';
import '../widgets/login_header_widget.dart';

class LoginMobileScreen extends StatelessWidget {
  const LoginMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(children: [
            // Header
            LoginHeaderWidget(),
            LoginFormWidget()
          ]),
        ),
      ),
    );
  }
}
