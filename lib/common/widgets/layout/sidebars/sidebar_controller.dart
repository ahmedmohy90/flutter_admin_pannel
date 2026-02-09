import 'package:admin_pannel/routes/routes.dart';
import 'package:admin_pannel/utils/device/device_utility.dart';
import 'package:get/get.dart';

class SidebarController extends GetxController {
  final activeItem = TRoutes.dashboard.obs;
  final hoverItem = "".obs;

  void changeActiveItem(String route) {
    activeItem.value = route;
  }

  void changeHoverItem(String route) {
    if (activeItem.value != route) {
      hoverItem.value = route;
    }
  }

  bool isActive(String route) => activeItem.value == route;

  bool isHovaring(String route) => hoverItem.value == route;

  void menuOnTap(String route) {
    if (!isActive(route)) {
      changeActiveItem(route);

      if (TDeviceUtils.isMobileScreen(Get.context!)) Get.back();

      Get.toNamed(route);
    }
  }
}
