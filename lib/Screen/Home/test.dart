import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tien/Config/api_urls.dart';
import 'package:tien/Screen/Favorite/nav_item.dart';

import '../../Config/favorite_helper.dart';
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

  @override
  Widget build(BuildContext context) {
    final List<String> bannerList = [
      'https://giaycuhanghieu.vn/thumbs/1366x720x1/upload/photo/slider-bnanner-44080.png',
      'https://vsneakershop.weebly.com/uploads/6/3/3/8/63388329/vsneaker-banner-gi-y_orig.png',
      'https://giaysneaker.store/media/wysiwyg/slidershow/home-12/banner_NEW_BALANCE.jpg',
    ];

    final List<String> brandImages = [
      'https://i.imghippo.com/files/FNqeF1720768332.png',
      'https://i.imghippo.com/files/iXXMx1720768355.png',
      'https://i.imghippo.com/files/j3e1M1720768443.png',
      'https://i.imghippo.com/files/4xKwU1720768473.png'
    ];

    return Scaffold(
      backgroundColor: Colors.grey[100],
      drawer: const Navbar(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Image.asset('assets/images/Logo.png', height: 80, width: 80),
        centerTitle: true,
        actions: [
          IconButton(
              icon: const Icon(Icons.shopping_cart_outlined,
                  color: Colors.deepPurple),
              onPressed: () {})
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                      color: Colors.deepPurple)),
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
                        });
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        width: 70,
                        height: 70,
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35),
                          border: Border.all(
                              color: selectedBrandIndex == index
                                  ? Colors.deepPurple
                                  : Colors.transparent,
                              width: 2),
                          image: DecorationImage(
                            image: NetworkImage(brandImages[index]),
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
                      color: Colors.deepPurple)),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Nike Jordan', style: GoogleFonts.nunito(fontSize: 16)),
                  InkWell(
                    onTap: () {}, // Add navigation to all products page
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
                      return Text("Error: ${snapshot.error}",
                          style: GoogleFonts.nunito());
                    } else if (snapshot.hasData) {
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
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          var product = snapshot.data![index];
                          return ShoeCard(product: product);
                        },
                      );
                    } else {
                      return const Text("No products found",
                          style: TextStyle(color: Colors.red));
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}

class ShoeCard extends StatefulWidget {
  final ProductModel product;
  ShoeCard({required this.product});
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
        content:
            Text(isFavorite ? "Added to favorites" : "Removed from favorites"),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 4,
      child: InkWell(
        onTap: () {}, // Placeholder for onTap action
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    child: Image.network(widget.product.imageURL, fit: BoxFit.cover),
                  ),
                  Positioned(
                    top: 8,
                    right: 95,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isFavorite = !isFavorite;
                        });
                      },
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
                  Text(widget.product.name,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(
                      '${NumberFormat('###,###,###').format(widget.product.price)} VND',
                      style: TextStyle(color: Colors.red)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: EdgeInsets.only(right: 8, bottom: 8),
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.blue,
                            child: IconButton(
                              icon: Icon(Icons.add, color: Colors.white),
                              onPressed: () {
                                // Logic to add to cart
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
