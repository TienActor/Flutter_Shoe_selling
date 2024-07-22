import 'package:flutter/material.dart';
import 'package:tien/data/product.dart';
import '../../data/cartItem.dart';


class CartProvider with ChangeNotifier {
  List<CartItem> _items = [];

  List<CartItem> get items => _items;

  void addProduct(ProductModel product) {
    CartItem? existingItem;
    try {
      existingItem = _items.firstWhere((item) => item.product.id == product.id);
    } catch (e) {
      existingItem = null;
    }

    if (existingItem != null) {
      existingItem.quantity++;
    } else {
      _items.add(CartItem(product: product, quantity: 1));
    }
    notifyListeners();
  }

  void removeProduct(ProductModel product) {
    _items.removeWhere((item) => item.product.id == product.id);
    notifyListeners();
  }

  

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  int get itemCount {
    return _items.fold(0, (sum, item) => sum + item.quantity);
  }


  double get total {
    return _items.fold(0, (previousValue, item) => previousValue + item.totalPrice);
  }
}