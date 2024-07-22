import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tien/Screen/Cart/cartProvider.dart';
import 'package:tien/Screen/Cart/cartPage.dart';
import 'package:tien/data/product.dart';

// trang chi tiet
class DetailPage extends StatelessWidget {
  final int productId;
  final String productName;
  final String productImage;
  final double productPrice;
  final String productDescription;
  final List<ProductModel> relatedProducts;
  final String token;

  const DetailPage(
      {Key? key,
      required this.productId,
      required this.productName,
      required this.productImage,
      required this.productPrice,
      required this.productDescription,
      required this.relatedProducts,
      required this.token})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isExpanded = false;

    return Scaffold(
      appBar: AppBar(
        title: Text('Giày Nam'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CartDetail(
                          token: token,
                        )),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(productImage),
            ),
            SizedBox(height: 16.0),
            Text(
              productName,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              '${NumberFormat('###,###,###').format(productPrice)} VND',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.red,
              ),
            ),
            SizedBox(height: 16.0),
            StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AnimatedCrossFade(
                      firstChild: Text(
                        productDescription,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 16.0),
                        textAlign: TextAlign.justify,
                      ),
                      secondChild: Text(
                        productDescription,
                        style: TextStyle(fontSize: 16.0),
                        textAlign: TextAlign.justify,
                      ),
                      crossFadeState: isExpanded
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,
                      duration: Duration(milliseconds: 200),
                    ),
                    SizedBox(height: 8.0),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isExpanded = !isExpanded;
                        });
                      },
                      child: Text(
                        isExpanded ? 'Thu gọn' : 'Xem thêm',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            SizedBox(height: 16.0),
            Text(
              'Sản phẩm liên quan',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: relatedProducts.map((relatedProduct) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPage(
                            productId: relatedProduct.id,
                            productName: relatedProduct.name,
                            productImage: relatedProduct.imageURL,
                            productPrice: relatedProduct.price,
                            productDescription: relatedProduct.description,
                            relatedProducts: relatedProducts,
                            token: token,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: 120,
                      margin: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        children: [
                          Image.network(
                            relatedProduct.imageURL,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            relatedProduct.name,
                            style: TextStyle(fontSize: 14.0),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Giá: ${NumberFormat('###,###,###').format(productPrice)} VND',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    final product = ProductModel(
                        id:
                            productId, // Bạn cần sử dụng id thực tế từ sản phẩm của bạn
                        name: productName,
                        description: productDescription,
                        imageURL: productImage,
                        price: productPrice,
                        categoryID:
                            0, // Bạn cần sử dụng categoryID thực tế từ sản phẩm của bạn
                        categoryName: '',
                        quantity: 1);

                    Provider.of<CartProvider>(context, listen: false)
                        .addProduct(product);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Đã thêm vào giỏ hàng'),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                  child: Text(
                    'Đặt hàng',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
