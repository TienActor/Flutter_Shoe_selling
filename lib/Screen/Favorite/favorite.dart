import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Config/api_urls.dart';
import '../../data/product.dart'; // Đảm bảo đường dẫn đến file ProductModel đúng
import 'package:http/http.dart' as http;

import '../Home/test.dart';

class FavoritePage extends StatefulWidget {
  final String token;
  const FavoritePage({Key? key,required this.token}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
 Future<List<ProductModel>>? favoriteProducts;

  @override
  void initState() {
    super.initState();
    loadFavoriteProductIds();
    //favoriteProducts = loadFavoriteProductIds();
  }

 Future<void> loadFavoriteProductIds() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favoriteIds = prefs.getKeys()
        .where((key) => prefs.getBool(key) == true)
        .toList();

   // Gọi API để lấy thông tin các sản phẩm yêu thích dựa trên danh sách ID
  try {
    // Bạn cần đảm bảo đã có accountID và token được truyền vào khi khởi tạo lớp này
    List<ProductModel> favoriteProducts = await APIRepository().fetchFavoriteProducts('Tie2023', favoriteIds, widget.token);

    // Cập nhật state với danh sách sản phẩm yêu thích mới
    setState(() {
       favoriteProducts = favoriteProducts;
    });
  } catch (e) {
    // Xử lý lỗi nếu có
    print("Không có sản phẩm nào được hiển thị: $e");
  }
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Favorite Products")),
      body: FutureBuilder<List<ProductModel>>(
        future: favoriteProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return GridView.builder(
              itemCount: snapshot.data!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) {
                return ShoeCard(product: snapshot.data![index]);
              },
            );
          } else {
            return const Text("No favorite products found");
          }
        },
      ),
    );
  }
}
