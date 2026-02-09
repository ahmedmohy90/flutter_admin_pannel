import 'package:admin_pannel/common/widgets/responsive/responsive_design.dart';
import 'package:admin_pannel/common/widgets/responsive/screens/desktop_layout.dart';
import 'package:admin_pannel/common/widgets/responsive/screens/mobile_layout.dart';
import 'package:admin_pannel/common/widgets/responsive/screens/tablet_layout.dart';
import 'package:admin_pannel/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class TSiteTemplate extends StatelessWidget {
  const TSiteTemplate(
      {super.key,
      this.mobile,
      this.tablet,
      this.desktop,
      this.userLayout = true});

  final Widget? mobile;
  final Widget? tablet;
  final Widget? desktop;
  final bool userLayout;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TResponsiveWidget(
          mobile: userLayout
              ? MobileLayout(body: mobile ?? desktop)
              : mobile ?? desktop ?? Container(),
          tablet: userLayout
              ? TabletLayout(body: tablet ?? desktop)
              : tablet ?? desktop ?? Container(),
          desktop: userLayout
              ? DesktopLayout(body: desktop)
              : desktop ?? Container()),
    );
  }
}
