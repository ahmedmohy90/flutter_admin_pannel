import 'package:admin_pannel/data/repositores/user/user_repository.dart';
import 'package:admin_pannel/features/authentication/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/popups/loaders.dart';
import '../../models/order_model.dart';

class OrderDetailsController extends GetxController {
  static OrderDetailsController get to => Get.find();

  RxBool loading = true.obs;
  Rx<OrderModel> order = OrderModel.empty().obs;
  Rx<UserModel> customer = UserModel.empty().obs;

  // load customer orders

  Future<void> getCustomerOfCurrentOrder() async {
    try {
      loading.value = true;
      final user =
          await UserRepository.instance.fetchUserDetails(order.value.userId);
      customer.value = user;
    } catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        TLoaders.errorSnackBar(
          title: "Something went wrong",
          message: e.toString(),
        );
      });
    } finally {
      loading.value = false;
    }
  }
}
