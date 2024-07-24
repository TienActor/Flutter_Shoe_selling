import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tien/Screen/Cart/cartProvider.dart';
import 'package:tien/Screen/Cart/paymentPage.dart';
import 'package:tien/data/product.dart';
import 'package:tien/data/user.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

import '../../data/cartItem.dart';

Future<UserData> loadUserData() async {
  final jsonString = await rootBundle.loadString('assets/json/user_data.json');
  final jsonResponse = json.decode(jsonString);
  return UserData.fromJson(jsonResponse);
}

class CartDetail extends StatefulWidget {
  final String token; // Thêm token

  const CartDetail({Key? key, required this.token}) : super(key: key);

  @override
  _CartDetailState createState() => _CartDetailState();
}

class _CartDetailState extends State<CartDetail> {
  Widget quantityButton(
      {required IconData icon,
      required VoidCallback onPressed,
      required Color color}) {
    return ClipOval(
      child: Material(
        color: color, // màu nền của nút
        child: InkWell(
          splashColor: Colors.grey, // màu hiệu ứng khi nhấn
          onTap: onPressed,
          child: SizedBox(
            width: 32,
            height: 32,
            child: Icon(icon, color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text("Giỏ hàng"),
      ),
      body: Column(
        children: [
          Expanded(
            child: cart.items.isEmpty
                ? Center(
                    child: Text("Giỏ hàng đang trống",
                        style: TextStyle(fontSize: 18, color: Colors.grey)),
                  )
                : ListView.builder(
                    itemCount: cart.items.length,
                    itemBuilder: (context, index) {
                      final item = cart.items[index];
                      return Card(
                        margin: EdgeInsets.all(8),
                        child: ListTile(
                          leading: Image.network(item.product.imageURL,
                              width: 70, height: 70, fit: BoxFit.cover),
                          title: Text(item.product.name),
                          subtitle: Text(
                              '${NumberFormat('###,###,###').format(item.product.price)} VND'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              quantityButton(
                                  icon: Icons.remove,
                                  onPressed: () {
                                    cart.decrementQuantity(item.product);
                                  },
                                  color: Colors.grey),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(item.quantity.toString()),
                              ),
                              quantityButton(
                                  icon: Icons.add,
                                  onPressed: () {
                                    cart.incrementQuantity(item.product);
                                  },
                                  color: Colors.blue),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  cart.removeProduct(item.product);
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content:
                                        Text('Đã xóa sản phẩm khỏi giỏ hàng'),
                                    duration: Duration(seconds: 2),
                                  ));
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
          Divider(),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Tổng tiền:',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                Text('${NumberFormat('###,###,###').format(cart.total)} VND',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () async {
                UserData userData = await loadUserData();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentPage(
                      totalAmount: cart.total,
                      discount: 200000,
                      cartItems: cart.items,
                      token: widget.token,
                      userData: userData,
                    ),
                  ),
                );
              },
              child: Text('Thanh toán', style: TextStyle(fontSize: 18)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(91, 158, 225, 100),
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              ),
            ),
          )
        ],
      ),
    );
  }
}
