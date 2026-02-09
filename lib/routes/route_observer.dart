import 'package:admin_pannel/routes/routes.dart';
import 'package:flutter/src/widgets/navigator.dart';
import 'package:get/get.dart';

import '../common/widgets/layout/sidebars/sidebar_controller.dart';

class RouteObserver extends GetObserver {
  @override
  void didPop(Route? route, Route? previousRoute) {
    final sidebarController = Get.find<SidebarController>();
    sidebarController.changeActiveItem('');
    if(previousRoute != null) {
      for(var routeName in TRoutes.sidebarMenuItems){
        if(previousRoute.settings.name == routeName){
          sidebarController.changeActiveItem(routeName);
          break;
        }
      }
    }
  }
}
