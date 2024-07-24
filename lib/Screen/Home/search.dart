import 'package:flutter/material.dart';
import 'package:tien/Screen/Home/test.dart';
import 'package:tien/data/product.dart';

class SearchResultPage extends StatelessWidget {
  final List<ProductModel> products;
  final String searchQuery;
   final String token; // Thêm token nếu cần cho mục đích xác thực hoặc thông tin khác


  SearchResultPage({required this.products, required this.searchQuery,required this.token});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kết quả tìm kiếm cho "$searchQuery"'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.75,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ShoeCard(
            product: products[index],
            token: token,
            relatedProducts: [],
          );
        },
      ),
    );
  }
}
