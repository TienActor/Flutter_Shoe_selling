import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Config/api_urls.dart';
import '../../data/product.dart'; // Đảm bảo đường dẫn đến file ProductModel đúng
import 'package:http/http.dart' as http;

import '../Home/test.dart';

class FavoritePage extends StatefulWidget {
  final String token;
  final String accountID;
  const FavoritePage({Key? key,required this.token, required this.accountID}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}
class _FavoritePageState extends State<FavoritePage> {
  Future<List<ProductModel>>? favoriteProducts;

  @override
  void initState() {
    super.initState();
    favoriteProducts = loadFavoriteProductIds(); // Assign the future correctly
  }

  Future<List<ProductModel>> loadFavoriteProductIds() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> favoriteIds = prefs.getKeys().where((key) {
    //return prefs.getBool(key) ?? false;
    var val = prefs.get(key);
    return val is bool &&  val == true;
    // if (val is bool) {
      
    //   return val;
    // } else {
    //   print("Không xác định được giá trị  $key: Expected bool, found ${val.runtimeType}");
    //   return false;
    // }
  }).toList();
if (favoriteIds.isEmpty) {
    return []; // Return an empty list if no favorites are marked
  }
  try {
      List<ProductModel> fetchedProducts = await fetchFavoriteProducts(widget.accountID, favoriteIds, widget.token);
      return fetchedProducts;
    } catch (e) {
      print("Error fetching products: $e");
      return [];
    }
    // try {
    //   List<ProductModel> fetchedProducts = await APIRepository().fetchFavoriteProducts('Tie2023', favoriteIds, widget.token);
    //   return fetchedProducts; // Ensure to return the list of ProductModel
    // } catch (e) {
    //   print("Error fetching products: $e");
    //   return []; // Return an empty list if an error occurs
    // }
  }

   Future<List<ProductModel>> fetchFavoriteProducts(String accountID, List<String> favoriteIds, String token) async {
    String queryParameters = favoriteIds.map((id) => 'id=$id').join('&');
    String url = "${ApiUrls.getListProduct}?${queryParameters}";

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((productJson) => ProductModel.fromJson(productJson)).toList();
      } else {
        throw Exception('Failed to load favorite products: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching favorite products: $e');
      throw e;
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