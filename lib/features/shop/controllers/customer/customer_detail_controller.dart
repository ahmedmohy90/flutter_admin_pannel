import 'package:admin_pannel/data/repositores/addresses/addresses_repository.dart';
import 'package:admin_pannel/data/repositores/user/user_repository.dart';
import 'package:admin_pannel/features/shop/models/order_model.dart';
import 'package:admin_pannel/utils/popups/loaders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../../../utils/exceptions/format_exceptions.dart';
import '../../../../utils/exceptions/platform_exceptions.dart';
import '../../../authentication/models/user_model.dart';

class CustomerDetailController extends GetxController {
  static CustomerDetailController get instance => Get.find();
  RxBool ordersLoading = true.obs;
  RxBool addressLoading = true.obs;
  RxInt sortColumnIndex = 1.obs;
  RxBool sortAscending = true.obs;
  RxList<bool> selectedRows = RxList<bool>([]);
  Rx<UserModel> customer = UserModel.empty().obs;
  final addressReository = Get.put(AddressesRepository());
  final searchTextController = TextEditingController();
  RxList<OrderModel> allCustomerOrders =
      <OrderModel>[].obs; // RxList<OrderModel>
  RxList<OrderModel> filteredCustomerOrders =
      <OrderModel>[].obs; // RxList<OrderModel>

  Future<void> getCutomersOrders() async {
    try {
      ordersLoading.value = true;

      if (customer.value.id.isEmpty) return;

      final orders =
          await UserRepository.instance.fetchUserOrders(customer.value.id);

      customer.value.orders = orders;
      allCustomerOrders.assignAll(orders);
      filteredCustomerOrders.assignAll(orders);

      selectedRows.assignAll(
        List.generate(orders.length, (_) => false),
      );
    } catch (e) {
      TLoaders.errorSnackBar(
        title: 'Oh Snap',
        message: e.toString(),
      );
    } finally {
      ordersLoading.value = false;
    }
  }

  Future<void> getCustomerAddress() async {
    try {
      addressLoading.value = true;
      if (customer.value.id.isNotEmpty) {
        customer.value.addresses =
            await addressReository.fetchUserAddresses(customer.value.id);
      }
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    } finally {
      addressLoading.value = false;
    }
  }

  void searchQuery(String query) {
    filteredCustomerOrders.assignAll(
      allCustomerOrders.where(
        (customer) =>
            customer.id.toLowerCase().contains(query.toLowerCase()) ||
            customer.orderDate.toString().contains(query.toLowerCase()),
      ),
    );
    update();
  }
}
