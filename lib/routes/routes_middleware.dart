import 'package:admin_pannel/data/repositores/authentication/authentication_repository.dart';
import 'package:admin_pannel/routes/routes.dart';
import 'package:flutter/src/widgets/navigator.dart';
import 'package:get/get.dart';

class TMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    return AuthenticationRepository.instance.isAuthenticated
        ? null
        : const RouteSettings(name: TRoutes.login);
  }
}
