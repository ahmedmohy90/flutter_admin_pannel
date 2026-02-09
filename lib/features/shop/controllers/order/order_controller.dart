import 'package:admin_pannel/data/abstract/base_data_table_controller.dart';
import 'package:admin_pannel/features/shop/models/order_model.dart';
import 'package:admin_pannel/utils/popups/loaders.dart';
import 'package:get/get.dart';

import '../../../../data/repositores/order/order_repository.dart';
import '../../../../utils/constants/enums.dart';

class OrderController extends BaseDataTableController<OrderModel> {
  static OrderController get instance => Get.find();

  RxBool statusLoader = false.obs;
  var orderStatus = OrderStatus.delivered.obs;
  final _orderRepository = Get.find<OrderRepository>();

  @override
  bool containsSearchQuery(OrderModel item, String query) {
    return item.id.toLowerCase().contains(query.toLowerCase());
  }

  @override
  Future<void> deleteItems(OrderModel item) async {
    await _orderRepository.deleteOrder(item.id);
  }

  @override
  Future<List<OrderModel>> fetchItems() async {
    sortAscending.value = false;
    return await _orderRepository.getAllOrders();
  }

  void sortById(int columnIndex, bool ascending) {
    sortByProperty(columnIndex, ascending,
        (OrderModel order) => order.totalAmount.toString().toLowerCase());
  }
  void sortByDate(int columnIndex, bool ascending) {
    sortByProperty(columnIndex, ascending,
        (OrderModel order) => order.orderDate.toString().toLowerCase());
  } 

  Future<void> updateOrderStatus(OrderModel order, OrderStatus newStatus) async {
    try{
      statusLoader.value = true;
      order.status = newStatus;
      await _orderRepository.updateOrderSpecificValue(
          order.docId, {'status': newStatus.name});

          updateItemFromLists(order);
          orderStatus.value = newStatus;
          TLoaders.successSnackBar(title: 'updated', message: 'order status updated successfully');
      statusLoader.value = false;
    }catch(e){
      TLoaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
    }finally{
      statusLoader.value = false; 

    }
  }
}
