import 'package:admin_pannel/data/abstract/base_data_table_controller.dart';
import 'package:admin_pannel/utils/constants/sizes.dart';
import 'package:admin_pannel/utils/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/repositores/category/category_repository.dart';
import '../../models/category_model.dart';

class CategoryController extends BaseDataTableController<CategoryModel> {
  static CategoryController get instance => Get.find();

  final _categoryRepository = Get.put(CategoryRepository());

  @override
  bool containsSearchQuery(CategoryModel item, String query) {
    return item.name.toLowerCase().contains(query.toLowerCase());
  }

  @override
  Future<void> deleteItems(CategoryModel item) async {
    await _categoryRepository.deleteCategory(item.id);
  }

  @override
  Future<List<CategoryModel>> fetchItems() async {
    return await _categoryRepository.fetchCategories();
  }

  void sortByName(int columnIndex, bool ascending) {
    sortByProperty(columnIndex, ascending,
        (CategoryModel category) => category.name.toLowerCase());
  }
}
