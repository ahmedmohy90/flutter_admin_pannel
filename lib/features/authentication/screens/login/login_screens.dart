import 'package:admin_pannel/common/widgets/layout/templates/site_layout.dart';
import 'package:admin_pannel/features/authentication/screens/login/responsive_screens/login_desktop_tablet_screen.dart';
import 'package:admin_pannel/features/authentication/screens/login/responsive_screens/login_mobile_screen.dart';
import 'package:flutter/material.dart';

class LoginScreens extends StatelessWidget {
  const LoginScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return const TSiteTemplate(
      userLayout: false,
      desktop: LoginDesktopTabletScreen(),
      mobile: LoginMobileScreen(),
    );
  }
}
