
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Config/api_urls.dart';
import '../data/product.dart';
import 'EditProduct.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductModel product;
  final String token;
  final String accountID;

  const ProductDetailScreen({
    Key? key,
    required this.product,
    required this.token,
    required this.accountID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
         backgroundColor: Colors.red,
        actions: [
          IconButton(
            icon: Icon(Icons.edit, color: Colors.blue),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProductScreen(
                      product: product, token: token, accountID: accountID),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.delete, color: Colors.green),
            onPressed: () => _confirmDelete(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                height: 300,
                width: double.infinity,
                child: Image.network(product.imageURL, fit: BoxFit.cover)),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.name,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  Text(
                    "Giá: ${NumberFormat('###,###,###').format(product.price)} VND",
                    style: TextStyle(fontSize: 20, color: Colors.red),
                  ),
                  SizedBox(height: 10),
                  Text("Hãng: ${product.categoryName}",
                      style:
                          TextStyle(fontSize: 18, fontStyle: FontStyle.italic)),
                  SizedBox(height: 10),
                  Text(product.description, style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Xác nhận xóa"),
          content: Text("Bạn có chắc muốn xóa ${product.name} ?"),
          actions: <Widget>[
            TextButton(
              child: Text('Hủy'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Xóa'),
              onPressed: () {
                _deleteProduct(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteProduct(BuildContext context) async {
    try {
      bool success =
          await APIRepository().removeProduct(product.id, accountID, token);
      if (success) {
        Navigator.pop(context,true); // Pop the current screen and send back 'true' to indicate success
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Xóa sản phẩm thành công')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Không thể xóa sản phẩm')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error occurred while deleting the product: $e')));
    }
  }
}
