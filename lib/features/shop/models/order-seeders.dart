import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../utils/constants/enums.dart';
import '../../authentication/models/user_model.dart';
import 'address_model.dart';
import 'cart_item_model.dart';
import 'order_model.dart';

class OrdersSeeder {
  static final _db = FirebaseFirestore.instance;
  static final _rand = Random();

  /// 🔥 ENTRY POINT
  static Future<void> seedAll() async {
    for (int i = 1; i <= 10; i++) {
      final userId = 'user_$i';

      await _seedUser(userId, i);
      await _seedAddresses(userId);
      await _seedOrders(userId);
    }

    print('✅ Users + Addresses + Orders seeded successfully');
  }

  // ================= USERS =================

  static Future<void> _seedUser(String userId, int index) async {
    final user = UserModel(
      id: userId,
      fisrtName: 'Customer',
      lastName: '$index',
      email: 'customer$index@test.com',
      userName: 'customer_$index',
      phoneNumber: '010000000$index',
      role: AppRole.user,
      profilePicture: '',
      createAt: DateTime.now(),
      updateAt: DateTime.now(),
    );

    await _db.collection('User').doc(user.id).set({
      ...user.toJson(),
      'Role': user.role!.name, // 🔴 مهم
      'CreateAt': Timestamp.fromDate(user.createAt!),
      'UpdateAt': Timestamp.fromDate(user.updateAt!),
    });
  }

  // ================= ADDRESSES =================

  static Future<void> _seedAddresses(String userId) async {
    for (int i = 1; i <= 2; i++) {
      final address = AddressModel(
        id: '',
        name: 'Customer Address $i',
        phoneNumber: '010000000$userId',
        street: 'Street $i',
        city: 'Cairo',
        state: 'Nasr City',
        country: 'Egypt',
        postalCode: '11765',
        selectedAddress: i == 1,
      );

      await _db
          .collection('User')
          .doc(userId)
          .collection('Addresses')
          .add(address.toJson());
    }
  }

  // ================= ORDERS =================

  static Future<void> _seedOrders(String userId) async {
    final statuses = OrderStatus.values;

    for (int i = 1; i <= 3; i++) {
      final status = statuses[_rand.nextInt(statuses.length)];

      final order = OrderModel(
        id: 'ORD-${1000 + _rand.nextInt(9000)}',
        userId: userId, // 🔥 الربط الأساسي
        status: status,
        items: [
          CartItemModel(
            productId: 'prod_$i',
            title: 'Product $i',
            price: 100 + i * 20,
            quantity: _rand.nextInt(3) + 1,
          ),
        ],
        totalAmount: 300 + i * 100,
        shippingCost: 30,
        taxCost: 15,
        orderDate: DateTime.now().subtract(Duration(days: i)),
        deliveryDate: status == OrderStatus.delivered ? DateTime.now() : null,
      );

      await _db.collection('Orders').add(order.toJson());
    }
  }
}
