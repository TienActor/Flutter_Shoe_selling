import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tien/Screen/Cart/cartProvider.dart';
import 'package:tien/Screen/Cart/paymentPage.dart';
import 'package:tien/data/user.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

Future<UserData> loadUserData() async {
  final jsonString = await rootBundle.loadString('assets/json/user_data.json');
  final jsonResponse = json.decode(jsonString);
  return UserData.fromJson(jsonResponse);
}

class CartDetail extends StatefulWidget {
  final String token; // Thêm token

  CartDetail({Key? key, required this.token}) : super(key: key);

  @override
  _CartDetailState createState() => _CartDetailState();
}

class _CartDetailState extends State<CartDetail> {
  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back)),
          title: Text("Trang giỏ hàng")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (context, index) {
                final item = cart.items[index];
                return ListTile(
                  leading: Image.network(item.product.imageURL),
                  title: Text(item.product.name),
                  subtitle: Text(
                      '${NumberFormat('###,###,###').format(item.product.price)} VND'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      cart.removeProduct(item.product);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Đã xóa sản phẩm khỏi giỏ hàng'),
                        duration: Duration(seconds: 2),
                      ));
                    },
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
                      products: cart.items.map((item) => item.product).toList(),
                      token: widget.token,
                      userData: userData,
                    ),
                  ),
                );
              },
              child: Text('Thanh toán', style: TextStyle(fontSize: 18)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              ),
            ),
          )
        ],
      ),
    );
  }
}
