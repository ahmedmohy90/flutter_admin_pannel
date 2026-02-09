import 'package:admin_pannel/common/widgets/containers/rounded_container.dart';
import 'package:admin_pannel/common/widgets/layout/headers/headers.dart';
import 'package:flutter/material.dart';

import '../../layout/sidebars/sidebar.dart';

class DesktopLayout extends StatelessWidget {
  DesktopLayout({super.key, this.body});

  Widget? body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(children: [
        const Expanded(child: TSidebar()),
        Expanded(
            flex: 5,
            child: Column(
              children: [
                // Header
                const Expanded(flex: 2, child: const THeader()),

                // Body
                Expanded(flex: 18, child: body ?? const SizedBox.shrink()),
              ],
            ))
      ]),
    );
  }
}
