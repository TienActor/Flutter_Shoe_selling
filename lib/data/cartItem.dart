import 'package:tien/data/product.dart';

class CartItem {
  ProductModel product;
  int quantity;

  CartItem({required this.product, required this.quantity});

  double get totalPrice => product.price * quantity;

   Map<String, dynamic> toJson() {
    return {
      'productID': product.id,
      'count': quantity,
    };
  }
}
