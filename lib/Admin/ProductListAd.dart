import 'package:flutter/material.dart';
import '../Config/api_urls.dart';
import '../data/product.dart';
import 'EditProduct.dart';
import 'ProductdetailAd.dart'; // Đảm bảo rằng bạn đã thêm thư viện Dio vào pubspec.yaml

class ProductListScreen extends StatefulWidget {
  final String token;
  final String accountID;

  const ProductListScreen(
      {Key? key, required this.token, required this.accountID})
      : super(key: key);

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  late Future<List<ProductModel>> products;

  @override
  void initState() {
    super.initState();
    products = APIRepository().fetchProducts(widget.accountID, widget.token);
  }

  void _reloadProductList() {
    setState(() {
      products = APIRepository().fetchProducts(widget.accountID, widget.token);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Danh sách sản phẩm"),
      ),
      body: FutureBuilder<List<ProductModel>>(
        future: products,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                ProductModel product = snapshot.data![index];
                return ListTile(
                  title: Text(product.name),
                  subtitle: Text(product.categoryName),
                  leading: Image.network(product.imageURL),
                  trailing: SizedBox(
                    width: 100, // Enough space for two icons
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue),
                          onPressed: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditProductScreen(
                                    product: product,
                                    token: widget.token,
                                    accountID: widget.accountID),
                              ),
                            );
                            if (result == true) {
                              _reloadProductList(); // Phương thức tái tải danh sách sản phẩm
                            }
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            // TODO: Add delete functionality or confirm dialog
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Xác nhận xóa"),
                                  content: Text(
                                      "Bạn có chắc muốn xóa ${product.name}?"),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: Text("Hủy"),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        // Perform delete operation
                                        Navigator.of(context).pop();
                                        print(
                                            'Delete button pressed for ${product.name}');
                                      },
                                      child: Text("Xoá"),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProductDetailScreen(product: product),
                      ),
                    );
                  },
                );
              },
            );
          } else {
            return Center(child: Text("No products found"));
          }
        },
      ),
    );
  }
}
