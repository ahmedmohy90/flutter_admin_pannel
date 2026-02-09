import 'package:admin_pannel/data/abstract/base_data_table_controller.dart';
import 'package:admin_pannel/data/repositores/banner/banner_repository.dart';
import 'package:get/get.dart';

import '../../models/banner_model.dart';

class BannerController extends BaseDataTableController<BannerModel> {
  static BannerController get instance => Get.find();

  final _bannerRepository = Get.put(BannerRepository());

  @override
  bool containsSearchQuery(BannerModel item, String query) {
    return false;
    // return item.name.toLowerCase().contains(query.toLowerCase());
  }

  @override
  Future<void> deleteItems(BannerModel item) async {
    await _bannerRepository.deleteBanner(item.id!);
  }

  @override
  Future<List<BannerModel>> fetchItems() async {
    return await _bannerRepository.getAllBanners();
  }
  //  method for formatting a route string
  String formatRoute(String route) {
    if (route.isEmpty) return '';
    //  remove the leading '/'
    String formatted = route.substring(1);
    // Capitalize the first letter
    formatted = formatted[0].toUpperCase() + formatted.substring(1);
    return formatted;
  }
}
