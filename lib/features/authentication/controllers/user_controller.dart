import 'package:admin_pannel/data/repositores/user/user_repository.dart';
import 'package:admin_pannel/features/authentication/models/user_model.dart';
import 'package:admin_pannel/utils/popups/loaders.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  RxBool loading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs; // Rx<User>

  final UserRepository userRepository = UserRepository();

  @override
  void onInit() {
    fetchUserDetails();
    super.onInit();
  }

  // fetches user details from the repository
  Future<UserModel> fetchUserDetails() async {
    try {
      loading.value = true;
      final user = await userRepository.fetchAdminDetails();
      this.user.value = user;
      loading.value = false;
      return user;
    } catch (e) {
      loading.value = false;
      TLoaders.errorSnackBar(
          title: "Something went wrong", message: e.toString());

      return UserModel.empty();
    }
  }
}
