import 'package:admin_pannel/common/widgets/layout/templates/site_layout.dart';
import 'package:admin_pannel/features/authentication/screens/forget_password/responsive_screens/forget_password_desktop_tablet_widget.dart';
import 'package:flutter/material.dart';

import 'responsive_screens/forget_password_mobile_widget.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TSiteTemplate(
      userLayout: false,
      desktop: ForgetPasswordDesktopTabletWidget(),
      mobile: ForgetPasswordMobileWidget(),
    );
  }
}
