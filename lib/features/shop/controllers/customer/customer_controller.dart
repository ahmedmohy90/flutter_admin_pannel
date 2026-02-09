import 'package:admin_pannel/data/abstract/base_data_table_controller.dart';
import 'package:admin_pannel/data/repositores/user/user_repository.dart';
import 'package:admin_pannel/features/authentication/models/user_model.dart';
import 'package:get/get.dart';

class CustomerController extends BaseDataTableController<UserModel> {
  static CustomerController get instance => Get.find();

  final _customerRepository = Get.put(UserRepository());
  @override
  bool containsSearchQuery(item, String query) {
    return item.fullName.toLowerCase().contains(query.toLowerCase());
  }

  void sortByName(int columnIndex, bool ascending) {
    sortByProperty(columnIndex, ascending, (o) => o.fullName.toLowerCase());
  }

  @override
  Future<void> deleteItems(item) async {
    await _customerRepository.deleteUser(item.id);
  }

  @override
  Future<List<UserModel>> fetchItems() {
    return _customerRepository.getAllUsers();
  }
}
