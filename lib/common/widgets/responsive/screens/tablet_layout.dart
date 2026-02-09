import 'package:admin_pannel/common/widgets/layout/headers/headers.dart';
import 'package:flutter/material.dart';

import '../../layout/sidebars/sidebar.dart';

class TabletLayout extends StatelessWidget {
  TabletLayout({super.key, this.body});

  Widget? body;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const TSidebar(),
      appBar: THeader(
        scaffoldKey: _scaffoldKey,
      ),
      body: body ?? const SizedBox.shrink(),
    );
  }
}
