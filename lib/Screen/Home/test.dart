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
  int selectedBrandIndex = -1; // Khởi tạo không có hãng nào được chọn
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
      'https://i.imghippo.com/files/4xKwU1720768473.png' // adidas // nike
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const Navbar(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Image.asset('assets/images/Logo.png', height: 80, width: 80),
        centerTitle: true,
        actions: [
          IconButton(
              icon:
                  const Icon(Icons.shopping_bag_outlined, color: Colors.black),
              onPressed: () {})
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CarouselSlider(
                options: CarouselOptions(
                    autoPlay: true,
                    enlargeCenterPage: true,
                    aspectRatio: 2.0,
                    height: 120),
                items: bannerList
                    .map((item) => Center(
                        child: Image.network(item,
                            fit: BoxFit.cover, width: 1000)))
                    .toList(),
              ),
              const SizedBox(height: 16),
              const Text('Sản phẩm theo hãng',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(brandImages.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedBrandIndex = index;
                      });
                    },
                    child: Container(
                      width: 70,
                      height: 70,
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: selectedBrandIndex == index
                            ? const Color.fromRGBO(91, 158, 225, 100)
                            : const Color.fromRGBO(172, 170, 170, 0.612),
                        image: DecorationImage(
                          image: NetworkImage(brandImages[index]),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 20),
              const Text('Giày phổ biến',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Nike Jordan'),
                  Text('Tất cả', style: TextStyle(color: Colors.blue))
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
                      return Text("Loi: ${snapshot.error}");
                    } else if (snapshot.hasData) {
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio:
                              0.75, // Adjust ratio according to your image and text layout
                        ),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          var product = snapshot.data![index];
                          return ShoeCard(
                              product:
                                  product); // Passing product data to ShoeCard
                        },
                      );
                    } else {
                      return const Text("Không tìm thấy sản phẩm");
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
  bool isFavorite = false; // Đặt biến trạng thái favorite ở đây
  @override
  void initState() {
    super.initState();
    _loadFavoriteStatus();
  }


  Future<void> _loadFavoriteStatus() async {
    final prefs = await SharedPreferences.getInstance();
    bool favoriteStatus = prefs.getBool(widget.product.id.toString()) ?? false;
    setState(() {
      isFavorite = favoriteStatus;
    });
  }

  /// thêm thông báo sản phẩm đã thêm vào yêu thích
  Future<void> _toggleFavorite() async {
    final prefs = await SharedPreferences.getInstance();
  
    bool newFavoriteStatus = !isFavorite;

    // Lưu trạng thái mới vào SharedPreferences
    await prefs.setBool(widget.product.id.toString(), newFavoriteStatus);

    // Cập nhật UI
    setState(() {
      isFavorite = newFavoriteStatus;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(isFavorite
            ? "Đã thêm sản phẩm yêu thích"
            : "Đã xóa sản phẩm yêu thích"),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 3.5,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.network(widget.product.imageURL,
                    fit: BoxFit.contain, height: 120),
                Positioned(
                  top: 8,
                  right: 75,
                  child: GestureDetector(
                    onTap: _toggleFavorite,
                    child: AnimatedSwitcher(
                      duration: Duration(milliseconds: 300),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                        return ScaleTransition(scale: animation, child: child);
                      },
                      child: isFavorite
                          ? Icon(Icons.favorite,
                              color: Colors.red,
                              key: ValueKey<bool>(isFavorite))
                          : Icon(Icons.favorite_border,
                              color: Colors.grey,
                              key: ValueKey<bool>(isFavorite)),
                    ),
                  ),
                ),
              ],
            ),
            const Text('BÁN CHẠY',
                style: TextStyle(fontSize: 14, color: Colors.blue)),
            const SizedBox(height: 4),
            Text(widget.product.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(
                '${NumberFormat('###,###,###').format(widget.product.price)} VND',
                style: GoogleFonts.zenAntiqueSoft(
                    fontSize: 12, fontWeight: FontWeight.bold)),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10)),
                child: const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Icon(Icons.add, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
