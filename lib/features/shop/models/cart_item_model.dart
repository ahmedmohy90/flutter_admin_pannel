class CartItemModel {
  String productId;
  String title;
  double price;
  String? image;
  int quantity;
  String variationId;
  String? brandName;
  Map<String, String>? selectedVariation;

  CartItemModel(
      {required this.productId,
      this.title = '',
      this.price = 0.0,
      this.image,
      required this.quantity,
      this.variationId = '',
      this.brandName,
      this.selectedVariation});

  // calculate total amount

  String get totalAmount => (price * quantity).toStringAsFixed(2);

  //  empty cart
  static CartItemModel empty() => CartItemModel(
        productId: '',
        quantity: 0,
      );

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'title': title,
      'price': price,
      'image': image,
      'quantity': quantity,
      'variationId': variationId,
      'brandName': brandName,
      'selectedVariation': selectedVariation,
    };
  }

  //  create a cartItem from a json map

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      productId: json['productId'],
      title: json['title'],
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      image: json['image'],
      quantity: json['quantity'],
      variationId: json['variationId'],
      brandName: json['brandName'],
      selectedVariation: json['selectedVariation'],
    );
  }
}
