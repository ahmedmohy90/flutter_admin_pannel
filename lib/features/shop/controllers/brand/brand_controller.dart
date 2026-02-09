import 'package:admin_pannel/features/shop/controllers/category/category_controller.dart';
import 'package:get/get.dart';

import '../../../../data/abstract/base_data_table_controller.dart';
import '../../../../data/repositores/brands/brand_repository.dart';
import '../../models/brand_model.dart';

class BrandController extends BaseDataTableController<BrandModel> {
  static BrandController get instance => Get.find();

  final _brandRepository = Get.put(BrandRepository());
  final categoryController = Get.put(CategoryController());

  @override
  bool containsSearchQuery(BrandModel item, String query) {
    return item.name.toLowerCase().contains(query.toLowerCase());
  }

  @override
  Future<void> deleteItems(BrandModel item) {
    return _brandRepository.deleteBrand(item);
  }

  void sortByName(int columnIndex, bool ascending) {
    sortByProperty(
        columnIndex, ascending, (BrandModel brand) => brand.name.toLowerCase());
  }

  @override
  Future<List<BrandModel>> fetchItems() async {
    final fetchedBrands = await _brandRepository.getAllBrands();

    final fetchedBrandCategories =
        await _brandRepository.getAllBrandCategories();
    // fetch all categories if data does not exist in cache
    if (categoryController.allItems.isNotEmpty)
      await categoryController.fetchItems();

    for (final brand in fetchedBrands) {
      List<String> categoryIds = fetchedBrandCategories
          .where((brandCategory) => brandCategory.brandId == brand.id)
          .map((brandCategory) => brandCategory.categoryId)
          .toList();

      brand.brandCategories = categoryController.allItems
          .where((category) => categoryIds.contains(category.id))
          .toList();
    }
    return fetchedBrands;
  }
}
