import 'package:admin_pannel/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/enums.dart';
import '../../models/order_model.dart';

class DashboardController extends GetxController {
  static DashboardController instance = Get.find();

  final RxList<double> weeklySales = <double>[].obs;

  final RxMap<OrderStatus, int> orderStatusData = <OrderStatus, int>{}.obs;
  final RxMap<OrderStatus, double> totalAmounts = <OrderStatus, double>{}.obs;

  static final List<OrderModel> orders = [
    OrderModel(
      id: 'CWT0012',
      status: OrderStatus.processing,
      totalAmount: 265,
      orderDate: DateTime(2025, 12, 1),
      deliveryDate: DateTime(2025, 12, 1),
      items: [],
      shippingCost: 0.0,
      taxCost: 0.0,
    ),
    OrderModel(
      id: 'CWT0025',
      status: OrderStatus.shipped,
      totalAmount: 369,
      orderDate: DateTime(2025, 12, 2),
      deliveryDate: DateTime(2025, 12, 2),
      items: [],
      shippingCost: 0.0,
      taxCost: 0.0,
    ),
    OrderModel(
      id: 'CWT0152',
      status: OrderStatus.delivered,
      totalAmount: 254,
      orderDate: DateTime(2025, 12, 3),
      deliveryDate: DateTime(2025, 12, 3),
      items: [],
      shippingCost: 0.0,
      taxCost: 0.0,
    ),
    OrderModel(
      id: 'CWT0265',
      status: OrderStatus.delivered,
      totalAmount: 355,
      orderDate: DateTime(2025, 12, 7),
      deliveryDate: DateTime(2025, 12, 4),
      items: [],
      shippingCost: 0.0,
      taxCost: 0.0,
    ),
    OrderModel(
      id: 'CWT1536',
      status: OrderStatus.delivered,
      totalAmount: 115,
      orderDate: DateTime(2025, 12, 6),
      deliveryDate: DateTime(2025, 12, 5),
      items: [],
      shippingCost: 0.0,
      taxCost: 0.0,
    ),
  ];

  @override
  void onInit() {
    _calculateWeeklySales();
    _calculateOrderStatusData();
    super.onInit();
  }

  void _calculateWeeklySales() {
    weeklySales.value = List<double>.filled(7, 0.0);
    for (var order in orders) {
      final DateTime orderWeekStart =
          THelperFunctions.getStartOfWeek(order.orderDate);

      //  check if the order is within  the current week
      if (orderWeekStart.isBefore(DateTime.now()) &&
          orderWeekStart.add(const Duration(days: 7)).isAfter(DateTime.now())) {
        int index = (order.orderDate.weekday - 1) % 7;

        index = index < 0 ? index + 7 : index;

        weeklySales[index] += order.totalAmount;
        print(
            'OrderDate: ${order.orderDate}, currentWeekDay: $orderWeekStart, index: $index');
      }
    }
    print('weekly Sales $weeklySales');
  }

  void _calculateOrderStatusData() {
    // RESET STATUS DATA
    orderStatusData.clear();

    // map to store total amounts for each status
    totalAmounts.value = {for (var status in OrderStatus.values) status: 0.0};
    for (var order in orders) {
      if (orderStatusData.containsKey(order.status)) {
        orderStatusData[order.status] =
            (orderStatusData[order.status] ?? 0) + 1;
        totalAmounts[order.status] =
            (totalAmounts[order.status] ?? 0) + order.totalAmount;
      } else {
        orderStatusData[order.status] = 1;
        totalAmounts[order.status] = order.totalAmount;
      }
    }
  }
}
