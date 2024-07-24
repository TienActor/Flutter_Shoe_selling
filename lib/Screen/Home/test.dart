import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tien/Config/api_urls.dart';
import 'package:tien/Screen/Cart/cartProvider.dart';
import 'package:tien/Screen/Cart/cartPage.dart';
import 'package:tien/Screen/Favorite/nav_item.dart';
import 'package:tien/Screen/Home/AllProduct.dart';
import 'package:tien/Screen/Home/detail.dart';
import 'package:tien/Screen/Home/search.dart';

import '../../Config/const.dart';
import '../../data/product.dart';

class ShoeStoreHome extends StatefulWidget {
  final String token;
  final String accountID;

  ShoeStoreHome({required this.token, required this.accountID});

  @override
  _ShoeStoreHomeState createState() => _ShoeStoreHomeState();
}

class _ShoeStoreHomeState extends State<ShoeStoreHome> {
  int selectedBrandIndex = -1;
  List<ProductModel> favoriteProducts = [];
  String selectedBrand = "";
  List<ProductModel> allProducts = []; // Danh sách tất cả sản phẩm
  List<ProductModel> filteredProducts = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  void _loadProducts() async {
    List<ProductModel> products =
        await APIRepository().fetchProducts(widget.accountID, widget.token);
    setState(() {
      allProducts = products;
      filteredProducts = products; // Thiết lập ban đầu
    });
  }

  void _filterProducts(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredProducts = List.from(
            allProducts); // Khôi phục lại danh sách ban đầu nếu không có tìm kiếm
      } else {
        filteredProducts = allProducts
            .where((product) =>
                product.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  void dispose  () {
    searchController.dispose();
    super.dispose();
  }

  Future<void> _refreshProducts() async {
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      drawer: Navbar(token: widget.token),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Image.asset('assets/images/logo.png', height: 80, width: 80),
        centerTitle: true,
        actions: [
          Consumer<CartProvider>(
            builder: (context, cart, child) {
              return Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart_outlined,
                        color: Colors.deepPurple),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CartDetail(token: widget.token),
                        ),
                      );
                    },
                  ),
                  if (cart.itemCount > 0)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          '${cart.itemCount}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshProducts,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Thanh tìm kiếm
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: TextField(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Tìm kiếm',
                        icon: Icon(Icons.search, color: Colors.grey),
                      ),
                      onSubmitted: (query) {
                        _filterProducts(query);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchResultPage(
                                      products: filteredProducts,
                                      searchQuery: query,
                                      token: widget.token,
                                    )));
                      },
                    ),
                  ),
                ),
                CarouselSlider(
                  options: CarouselOptions(
                      autoPlay: true,
                      enlargeCenterPage: true,
                      aspectRatio: 2.0,
                      height: 180),
                  items: bannerList
                      .map((item) => Center(
                          child: Image.network(item,
                              fit: BoxFit.cover, width: 1000)))
                      .toList(),
                ),
                const SizedBox(height: 24),
                Text('Sản phẩm theo hãng',
                    style: GoogleFonts.nunito(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                const SizedBox(height: 16),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(brandImages.length, (index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedBrandIndex = index;
                            selectedBrand = brandImages[index]['name']!;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          width: 70,
                          height: 70,
                          margin: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                color: selectedBrandIndex == index
                                    ? Colors.deepPurple
                                    : Colors.transparent,
                                width: 2),
                            image: DecorationImage(
                              image: NetworkImage(brandImages[index]['image']!),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                const SizedBox(height: 24),
                Text('Giày phổ biến',
                    style: GoogleFonts.nunito(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Nike Jordan',
                        style: GoogleFonts.nunito(fontSize: 16)),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AllProductsPage(
                                token: widget.token,
                                accountID: widget.accountID),
                          ),
                        );
                      }, // Add navigation to all products page
                      child: Text('Tất cả',
                          style: GoogleFonts.nunito(
                              color: Colors.blue,
                              fontSize: 16,
                              decoration: TextDecoration.underline)),
                    )
                  ],
                ),
                const SizedBox(height: 8),
                FutureBuilder<List<ProductModel>>(
                    future: APIRepository()
                        .fetchProducts(widget.accountID, widget.token),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Text("Lỗi: ${snapshot.error}",
                            style: GoogleFonts.nunito());
                      } else if (snapshot.hasData) {
                        List<ProductModel> filteredProducts =
                            selectedBrand.isEmpty
                                ? snapshot.data!
                                : snapshot.data!
                                    .where((product) =>
                                        product.categoryName == selectedBrand)
                                    .toList();
                        return GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 0.75,
                          ),
                          itemCount: filteredProducts.length,
                          itemBuilder: (context, index) {
                            var product = filteredProducts[
                                index]; // Sử dụng filteredProducts
                            var relatedProducts = snapshot.data!
                                .where(
                                    (p) => p.categoryID == product.categoryID)
                                .toList();
                            return ShoeCard(
                              product: product,
                              relatedProducts: relatedProducts,
                              token: widget.token,
                            );
                          },
                        );
                      } else {
                        return const Text("Không có sản phẩm nào",
                            style: TextStyle(color: Colors.red));
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ShoeCard extends StatefulWidget {
  final ProductModel product;
  final String token;
  final List<ProductModel> relatedProducts;
  ShoeCard(
      {required this.product,
      required this.token,
      required this.relatedProducts});
  @override
  _ShoeCardState createState() => _ShoeCardState();
}

class _ShoeCardState extends State<ShoeCard> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _loadFavoriteStatus();
  }

  Future<void> _loadFavoriteStatus() async {
    final prefs = await SharedPreferences.getInstance();
    var favoriteStatus = prefs.get(widget.product.id.toString());
    if (favoriteStatus is bool) {
      setState(() {
        isFavorite = favoriteStatus;
      });
    } else {
      setState(() {
        isFavorite = false;
      });
    }
  }

  Future<void> _toggleFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    bool newFavoriteStatus = !isFavorite;
    await prefs.setBool(widget.product.id.toString(), newFavoriteStatus);
    setState(() {
      isFavorite = newFavoriteStatus;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(isFavorite ? "Đã yêu thích" : "Đã xóa yêu thích"),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 4,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailPage(
                productId: widget.product.id,
                productName: widget.product.name,
                productImage: widget.product.imageURL,
                productPrice: widget.product.price,
                productDescription: widget.product.description,
                relatedProducts: widget.relatedProducts,
                token: widget.token,
              ),
            ),
          );
        },
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(20)),
                    child: Image.network(widget.product.imageURL,
                        fit: BoxFit.cover),
                  ),
                  Positioned(
                    top: 8,
                    right: 108,
                    child: GestureDetector(
                      onTap: _toggleFavorite,
                      child: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : Colors.grey,
                        size: 24,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    maxLines: 1,
                  ),
                  Text(
                      '${NumberFormat('###,###,###').format(widget.product.price)} VND',
                      style: const TextStyle(color: Colors.red)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8, bottom: 8),
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.blue,
                            child: IconButton(
                              icon: const Icon(Icons.add, color: Colors.white),
                              onPressed: () {
                                Provider.of<CartProvider>(context,
                                        listen: false)
                                    .addProduct(widget.product);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text("Đã thêm vào giỏ hàng thành công"),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
