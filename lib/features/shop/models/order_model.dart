import 'dart:developer';

import 'package:admin_pannel/utils/constants/enums.dart';
import 'package:admin_pannel/utils/helpers/helper_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'address_model.dart';
import 'cart_item_model.dart';

class OrderModel {
  OrderModel(
      {required this.id,
      this.userId = '',
      this.docId = '',
      required this.status,
      required this.items,
      required this.totalAmount,
      required this.shippingCost,
      required this.taxCost,
      required this.orderDate,
      this.paymentMethod = 'Cash on Delivery',
      this.shippingAddress,
      this.billingAddress,
      this.deliveryDate,
      this.billingAddressSameAsShipping = true});

  final String id;
  final String docId;
  final String userId;
  OrderStatus status;
  final double totalAmount;
  final double shippingCost;
  final double taxCost;
  final DateTime orderDate;
  final String paymentMethod;
  final AddressModel? shippingAddress;
  final AddressModel? billingAddress;
  final DateTime? deliveryDate;
  final List<CartItemModel> items;
  final bool billingAddressSameAsShipping;

  String get formattedOrderDate => THelperFunctions.getFormattedDate(orderDate);
  String get formattedDeliveryDate => deliveryDate != null
      ? THelperFunctions.getFormattedDate(deliveryDate!)
      : '';

  String get orderStatusText => status == OrderStatus.delivered
      ? 'Delivered'
      : status == OrderStatus.shipped
          ? 'Shipment on the way'
          : 'Pending';

  static OrderModel empty() => OrderModel(
      id: '',
      userId: '',
      docId: '',
      status: OrderStatus.pending,
      items: [],
      totalAmount: 0.0,
      shippingCost: 0.0,
      taxCost: 0.0,
      orderDate: DateTime.now(),
      paymentMethod: 'Cash on Delivery',
      shippingAddress: null,
      billingAddress: null,
      deliveryDate: null,
      billingAddressSameAsShipping: true);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'docId': docId,
      'status': status.name,
      'items': items.map((item) => item.toJson()).toList(),
      'totalAmount': totalAmount,
      'shippingCost': shippingCost,
      'taxCost': taxCost,
      'orderDate': orderDate,
      'paymentMethod': paymentMethod,
      'shippingAddress': shippingAddress?.toJson(),
      'billingAddress': billingAddress?.toJson(),
      'deliveryDate': deliveryDate,
      'billingAddressSameAsShipping': billingAddressSameAsShipping,
    };
  }

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      userId: json['userId'],
      docId: json['docId'],
      status: OrderStatus.values.byName(json['status']),
      items: json.containsKey('items')
          ? (json['items'] as List<dynamic>)
              .map((item) => CartItemModel.fromJson(item))
              .toList()
          : [],
      totalAmount: json['totalAmount'],
      shippingCost: json['shippingCost'],
      taxCost: json['taxCost'],
      orderDate: json['orderDate'],
      paymentMethod: json['paymentMethod'],
      shippingAddress: json.containsKey('shippingAddress')
          ? AddressModel.fromMap(json['shippingAddress'])
          : AddressModel.empty(),
      billingAddress: json.containsKey('billingAddress')
          ? AddressModel.fromMap(json['billingAddress'])
          : AddressModel.empty(),
      deliveryDate: json['deliveryDate'] != null
          ? DateTime.parse(json['deliveryDate'])
          : null,
      billingAddressSameAsShipping: json['billingAddressSameAsShipping'],
    );
  }
  factory OrderModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() != null
        ? snapshot.data()! as Map<String, dynamic>
        : <String, dynamic>{};

    return OrderModel(
      docId: snapshot.id,
      id: data['id'] ?? '',
      userId: data['userId'] ?? '',
      status: data['status'] != null
          ? OrderStatus.values.byName(data['status'])
          : OrderStatus.pending,
      items: data['items'] != null
          ? List<CartItemModel>.from(
              (data['items'] as List)
                  .map((item) => CartItemModel.fromJson(item)),
            )
          : [],
      totalAmount: (data['totalAmount'] ?? 0).toDouble(),
      shippingCost: (data['shippingCost'] ?? 0).toDouble(),
      taxCost: (data['taxCost'] ?? 0).toDouble(),
      orderDate: data['orderDate'] != null
          ? (data['orderDate'] as Timestamp).toDate()
          : DateTime.now(),
      paymentMethod: data['paymentMethod'] ?? 'Cash on Delivery',
      shippingAddress: data['shippingAddress'] != null
          ? AddressModel.fromMap(data['shippingAddress'])
          : null,
      billingAddress: data['billingAddress'] != null
          ? AddressModel.fromMap(data['billingAddress'])
          : null,
      deliveryDate: data['deliveryDate'] != null
          ? (data['deliveryDate'] as Timestamp).toDate()
          : null,
      billingAddressSameAsShipping:
          data['billingAddressSameAsShipping'] ?? true,
    );
  }
}
