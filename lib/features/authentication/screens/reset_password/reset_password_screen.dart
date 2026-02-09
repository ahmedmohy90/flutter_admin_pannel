import 'package:flutter/material.dart';

import '../../../../common/widgets/layout/templates/site_layout.dart';
import 'responsive_screens/reset_password_desktop_tablet_widget.dart';
import 'responsive_screens/reset_password_mobile_widget.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TSiteTemplate(
      userLayout: false,
      desktop: ResetPasswordDesktopTabletWidget(),
      mobile: ResetPasswordMobileWidget(),
    );
  }
}
