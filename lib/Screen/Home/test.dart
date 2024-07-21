import 'package:flutter/material.dart';
<<<<<<< Updated upstream
import 'package:tien/Screen/Home/navbar.dart';
=======
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tien/Config/api_urls.dart';
import 'package:tien/Screen/Favorite/nav_item.dart';
import 'package:tien/Screen/Home/detail.dart';

import '../../data/product.dart';

class ShoeStoreHome extends StatefulWidget {
  final String token;
  final String accountID;
  const ShoeStoreHome({super.key, required this.token, required this.accountID});

  @override
  _ShoeStoreHomeState createState() => _ShoeStoreHomeState();
}

class _ShoeStoreHomeState extends State<ShoeStoreHome> {
  int selectedBrandIndex = -1;
  List<ProductModel> favoriteProducts = [];
  String selectedBrand = "";
>>>>>>> Stashed changes

class ShoeStoreHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
<<<<<<< Updated upstream
=======
    final List<String> bannerList = [
      'https://giaycuhanghieu.vn/thumbs/1366x720x1/upload/photo/slider-bnanner-44080.png',
      'https://vsneakershop.weebly.com/uploads/6/3/3/8/63388329/vsneaker-banner-gi-y_orig.png',
      'https://giaysneaker.store/media/wysiwyg/slidershow/home-12/banner_NEW_BALANCE.jpg',
    ];

    final List<Map<String, String>> brandImages = [
      {'name': 'Nike', 'image': 'https://i.imghippo.com/files/FNqeF1720768332.png'},
      {'name': 'Puma', 'image': 'https://i.imghippo.com/files/iXXMx1720768355.png'},
      {'name': 'Adidas', 'image': 'https://i.imghippo.com/files/j3e1M1720768443.png'},
      {'name': 'Converse', 'image': 'https://i.imghippo.com/files/4xKwU1720768473.png'}
    ];

>>>>>>> Stashed changes
    return Scaffold(
      drawer: Navbar(), // Sử dụng Navbar trong Drawer
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () {
              Scaffold.of(context).openDrawer(); // Mở Drawer khi ấn vào Icon menu
            },
          ),
        ),
        title: Image.asset(
          'assets/images/Logo.png',
          height: 40,
          width: 40,
        ),
        centerTitle: true,
        actions: [
          IconButton(
<<<<<<< Updated upstream
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.shopping_bag_outlined, color: Colors.black),
            onPressed: () {},
          ),
=======
              icon: const Icon(Icons.shopping_cart_outlined,
                  color: Colors.deepPurple),
              onPressed: () {
                // Thêm chức năng cho giỏ hàng tại đây
              })
>>>>>>> Stashed changes
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Sản phẩm theo hãng',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
<<<<<<< Updated upstream
=======
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
                          borderRadius: BorderRadius.circular(35),
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
                      color: Colors.deepPurple)),
              const SizedBox(height: 8),
>>>>>>> Stashed changes
              Row(
                children: [
                  BrandLogo(
                    imageUrl: 'https://i.pinimg.com/736x/d4/20/46/d4204662d48e847dbf4dff048863546c.jpg',
                  ),
                  const SizedBox(width: 48),
                  BrandLogo(
                    imageUrl: 'https://w1.pngwing.com/pngs/1009/652/png-transparent-puma-logo-tshirt-sneakers-clothing-accessories-coat-black-black-and-white-silhouette.png',
                  ),
                  const SizedBox(width: 48),
                  BrandLogo(
                    imageUrl: 'https://i.pinimg.com/originals/8c/b0/8a/8cb08a963150553f12dc40795e5cb4a3.jpg',
                  ),
                  const SizedBox(width: 32),
                  BrandLogo(
                    imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRNK1AiMRLKgSuS0kxX4UIrblJR3-ewdmI64A&s',
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Giày phổ biến',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
<<<<<<< Updated upstream
                  Text('Nike Jordan'),
                  Text('Tất cả', style: TextStyle(color: Colors.blue)),
                ],
              ),
              const SizedBox(height: 8),
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 2 / 3,
                ),
                itemCount: 6, // Number of items
                itemBuilder: (context, index) {
                  return ShoeCard();
                },
              ),
=======
                  Text('Nike Jordan', style: GoogleFonts.nunito(fontSize: 16)),
                  InkWell(
                    onTap: () {}, // Thêm chức năng điều hướng tới trang tất cả sản phẩm
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
                      List<ProductModel> filteredProducts = selectedBrand.isEmpty
                          ? snapshot.data!
                          : snapshot.data!
                              .where((product) => product.categoryName == selectedBrand)
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
                          var product = filteredProducts[index];
                          var relatedProducts = snapshot.data!
                              .where((p) => p.categoryID == product.categoryID)
                              .toList();
                          return ShoeCard(
                            product: product,
                            relatedProducts: relatedProducts,
                          );
                        },
                      );
                    } else {
                      return const Text("Không có sản phẩm nào",
                          style: TextStyle(color: Colors.red));
                    }
                  })
>>>>>>> Stashed changes
            ],
          ),
        ),
      ),
    );
  }
}

<<<<<<< Updated upstream
class BrandLogo extends StatelessWidget {
  final String imageUrl;

  const BrandLogo({required this.imageUrl});
=======

class ShoeCard extends StatefulWidget {
  final ProductModel product;
  final List<ProductModel> relatedProducts;

  const ShoeCard({
    Key? key,
    required this.product,
    required this.relatedProducts,
  }) : super(key: key);

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
        content: Text(
            isFavorite ? "Đã thêm vào mục yêu thích" : "Đã xóa khỏi mục yêu thích"),
        duration: const Duration(seconds: 2),
      ),
    );
  }
>>>>>>> Stashed changes

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(40)),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

class ShoeCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
<<<<<<< Updated upstream
      child: Padding(
        padding: const EdgeInsets.all(8.0),
=======
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailPage(
                productName: widget.product.name,
                productImage: widget.product.imageURL,
                productPrice: widget.product.price,
                productDescription: widget.product.description,
                relatedProducts: widget.relatedProducts,
              ),
            ),
          );
        },
>>>>>>> Stashed changes
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
<<<<<<< Updated upstream
            Stack(
              children: [
                Image.asset(
                  'assets/images/Hnhsnphm.png',
                  height: 100,
                ),
                const Positioned(
                  top: 8,
                  right: 8,
                  child: Icon(Icons.favorite_border, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'BÁN CHẠY',
              style: TextStyle(fontSize: 12, color: Colors.blue),
            ),
            const SizedBox(height: 4),
            const Text(
              'Nike Air Max',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              '3,000,000 VND',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Icon(Icons.add, color: Colors.white),
                ),
=======
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                    child: Image.network(widget.product.imageURL,
                        fit: BoxFit.cover),
                  ),
                  Positioned(
                    top: 8,
                    right: 95,
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
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.product.name,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(
                      '${NumberFormat('###,###,###').format(widget.product.price)} VND',
                      style: TextStyle(color: Colors.red)),
                ],
>>>>>>> Stashed changes
              ),
            ),
          ],
        ),
      ),
    );
  }
}