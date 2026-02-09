import 'package:admin_pannel/data/abstract/base_data_table_controller.dart';
import 'package:admin_pannel/features/shop/models/product_model.dart';
import 'package:admin_pannel/utils/constants/enums.dart';
import 'package:get/get.dart';

import '../../../../data/repositores/product/product_repository.dart';

class ProductsController extends BaseDataTableController<ProductModel> {
  static ProductsController get instance => Get.find();

  final _productRepository = ProductRepository.instance;

  @override
  bool containsSearchQuery(ProductModel item, String query) {
    return item.title.toLowerCase().contains(query.toLowerCase()) ||
        item.brand!.name.toLowerCase().contains(query.toLowerCase()) ||
        item.stock.toString().contains(query.toLowerCase()) ||
        item.price.toString().contains(query.toLowerCase());
  }

  @override
  Future<void> deleteItems(ProductModel item) {
    return _productRepository.deleteProduct(item.id);
  }

  @override
  Future<List<ProductModel>> fetchItems() async {
    return _productRepository.getAllProducts();
  }

  void sortByName(int columnIndex, bool ascending) {
    sortByProperty(columnIndex, ascending,
        (ProductModel product) => product.title.toLowerCase());
  }

  void sortByPrice(int columnIndex, bool ascending) {
    sortByProperty(
        columnIndex, ascending, (ProductModel product) => product.price);
  }

  void sortByStock(int columnIndex, bool ascending) {
    sortByProperty(
        columnIndex, ascending, (ProductModel product) => product.stock);
  }

  void sortBySoldItems(int columnIndex, bool ascending) {
    sortByProperty(
        columnIndex, ascending, (ProductModel product) => product.soldQuantity);
  }

  // get product price or price range for variations
  String getProductPrice(ProductModel product) {
    //  if no variations exist return simple price
    if (product.productType == ProductType.single.toString() ||
        product.variations.isEmpty) {
      return (product.salePrice > 0.0
          ? product.salePrice.toStringAsFixed(2)
          : product.price.toStringAsFixed(2));
    } else {
      double smallestPrice = double.infinity;
      double largePrice = 0.0;

      for (var variation in product.variations) {
        double priceToConsider =
            variation.salePrice > 0.0 ? variation.salePrice : variation.price;
        if (priceToConsider < smallestPrice) {
          smallestPrice = priceToConsider;
        }
        if (priceToConsider > largePrice) {
          largePrice = priceToConsider;
        }
      }

      if (smallestPrice.isEqual(largePrice)) {
        return largePrice.toStringAsFixed(2);
      } else {
        return '${smallestPrice.toStringAsFixed(2)} - ${largePrice.toStringAsFixed(2)}';
      }
    }
  }

  String? calculateSalePercentage(double originalPrice, double? salePrice) {
    if (salePrice == null || salePrice <= 0.0) {
      return null;
    } else {
      double salePercentage =
          ((originalPrice - salePrice) / originalPrice) * 100;
      return '${salePercentage.toStringAsFixed(2)}%';
    }
  }

  String getProductStockTotal(ProductModel product) {
    return product.productType == ProductType.single.toString()
        ? product.stock.toString()
        : product.variations
            .fold(0, (previousValue, element) => previousValue + element.stock)
            .toString();
  }

  String getProductSoldQuantity(ProductModel product) {
    return product.productType == ProductType.single.toString()
        ? product.soldQuantity.toString()
        : product.variations
            .fold(
                0,
                (previousValue, element) =>
                    previousValue + element.soldQuantity)
            .toString();
  }

  String getProductStockStatus(ProductModel product) {
    return product.stock > 0 ? 'In Stock' : 'Out of Stock';
  }
}
