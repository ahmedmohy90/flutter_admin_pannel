import 'package:admin_pannel/features/authentication/controllers/user_controller.dart';
import 'package:admin_pannel/utils/constants/enums.dart';
import 'package:admin_pannel/utils/constants/image_strings.dart';
import 'package:admin_pannel/utils/constants/text_strings.dart';
import 'package:admin_pannel/utils/popups/full_screen_loader.dart';
import 'package:admin_pannel/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../data/repositores/authentication/authentication_repository.dart';
import '../../../data/repositores/user/user_repository.dart';
import '../../../utils/helpers/network_manager.dart';
import '../models/user_model.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  final hidePassword = true.obs;
  final rememberMe = false.obs;
  final localStorage = GetStorage();

  final email = TextEditingController();
  final password = TextEditingController();
  final loginFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    email.text = localStorage.read('REMMBER_ME_EMAIL') ?? '';
    password.text = localStorage.read('REMMBER_ME_PASSWORD') ?? '';
    super.onInit();
  }

  // Handle email and password sign-in proccess
  Future<void> emailAndPasswordSignIn() async {
    try {
      // Start loading
      TFullScreenLoader.openLoadingDialog(
          'Registeration Admin Account...', TImages.docerAnimation);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      if (!loginFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }
      if (rememberMe.value) {
        localStorage.write('REMMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMMBER_ME_PASSWORD', password.text.trim());
      }
      await AuthenticationRepository.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text.trim());
      final user = await UserController.instance.fetchUserDetails();

      TFullScreenLoader.stopLoading();

      if (user.role != AppRole.admin) {
        await AuthenticationRepository.instance.logout();
        TLoaders.errorSnackBar(
            title: "Not Authorized",
            message: 'You are not authorized or have access. Contact Admin');
      } else {
        AuthenticationRepository.instance.screenRedirect();
      }
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh snap', message: e.toString());
    }
  }

  // handle registeration of admin user
  Future<void> registerAdmin() async {
    try {
      // Start loading
      TFullScreenLoader.openLoadingDialog(
          'Registeration Admin Account...', TImages.docerAnimation);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }
      await AuthenticationRepository.instance.registerWithEmailAndPassword(
          TTexts.adminEmail, TTexts.adminPassword);
      // Create admin record in firestore
      final userRepository = Get.put(UserRepository());

      await userRepository.createUser(
        UserModel(
          id: AuthenticationRepository.instance.authUser!.uid,
          fisrtName: "Ahmed",
          lastName: "Mohy",
          email: TTexts.adminEmail,
          role: AppRole.admin,
          createAt: DateTime.now(),
        ),
      );
      TFullScreenLoader.stopLoading();

      AuthenticationRepository.instance.screenRedirect();
    } catch (e, st) {
      print("🔥 REGISTER ADMIN ERROR => $e");
      print("🔥 STACKTRACE => $st");
      TFullScreenLoader.stopLoading();
      rethrow;
    }
  }
}
