import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/constants/sizes.dart';
import '../../utils/popups/full_screen_loader.dart';
import '../../utils/popups/loaders.dart';

abstract class BaseDataTableController<T> extends GetxController {
  RxBool isLoading = true.obs;
  RxList<T> allItems = <T>[].obs;
  RxList<T> filteredItems = <T>[].obs; // <CategoryModel>

  RxList<bool> selectedRows = <bool>[].obs;

  // sorting

  RxInt sortColumnIndex = 1.obs;
  RxBool sortAscending = true.obs;

  // search

  final searchTextController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<List<T>> fetchItems();

  Future<void> deleteItems(T item);

  bool containsSearchQuery(T item, String query);

  void fetchData() async {
    try {
      isLoading.value = true;
      List<T> fetchedItems = [];

      if (allItems.isEmpty) {
        fetchedItems = await fetchItems();
      }
      allItems.assignAll(fetchedItems);
      filteredItems.assignAll(allItems);
      selectedRows.assignAll(List.generate(allItems.length, (_) => false));
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      TLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

// common method for searching based on a query
  searchQuery(String query) {
    filteredItems.assignAll(
        allItems.where((element) => containsSearchQuery(element, query)));
  }

  void sortByProperty(
      int sortColumnIndex, bool ascending, Function(T) property) {
    this.sortColumnIndex.value = sortColumnIndex;
    sortAscending.value = ascending;
    filteredItems.sort((a, b) => ascending
        ? property(a).compareTo(property(b))
        : property(b).compareTo(property(a)));
  }

  void addItemToList(T item) {
    allItems.add(item);
    filteredItems.add(item);
    selectedRows.assignAll(List.generate(allItems.length, (_) => false));
  }

  void updateItemFromLists(T item) {
    int index = allItems.indexWhere((i) => i == item);
    int filteredItemIndex = filteredItems.indexWhere(
      (i) => i == item,
    );

    if (index != -1) allItems[index] = item;
    if (filteredItemIndex != -1) filteredItems[index] = item;
   
  }

  removeItemFromLists(T item) {
    allItems.remove(item);
    filteredItems.remove(item);
    selectedRows.assignAll(List.generate(allItems.length, (_) => false));

  }

   void confirmAndDeleteItem(T item) {
    Get.defaultDialog(
      title: "Delete Item",
      content: const Text("Are you sure you want to delete this item?"),
      confirm: SizedBox(
        width: 60,
        child: ElevatedButton(
            onPressed: () async => await deleteOnConfirm(item),
            style: OutlinedButton.styleFrom(
              padding:
                  const EdgeInsets.symmetric(vertical: TSizes.buttonHeight / 2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(TSizes.buttonRadius * 5),
              ),
            ),
            child: const Text('OK')),
      ),
      cancel: SizedBox(
        width: 80,
        child: OutlinedButton(
            onPressed: () => Get.back(),
            style: OutlinedButton.styleFrom(
              padding:
                  const EdgeInsets.symmetric(vertical: TSizes.buttonHeight / 2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(TSizes.buttonRadius * 5),
              ),
            ),
            child: const Text('Cancel')),
      ),
    );
  }

  deleteOnConfirm(T item) async {
    try {
      TFullScreenLoader.stopLoading();

      TFullScreenLoader.popUpCircular();

      await deleteItems(item);

      removeItemFromLists(item);

      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(
          title: "Item Deleted", message: "Item has been deleted");
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    }
  }

}
