import 'package:flutter/material.dart';
<<<<<<< Updated upstream
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:tien/Config/api_urls.dart';

import '../../data/product.dart';

=======
import 'package:intl/intl.dart';

import '../../Config/api_urls.dart';
import '../../data/product.dart';
>>>>>>> Stashed changes

class ShoeStoreHome extends StatelessWidget {
  final String token;
  final String accountID;
<<<<<<< Updated upstream

=======
  
>>>>>>> Stashed changes
  ShoeStoreHome({required this.token, required this.accountID});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () {
            // Add functionality to handle navigation drawer
          },
        ),
        title: Image.asset(
          'assets/images/Logo.png',
          height: 40,
          width: 40,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {
              // Add functionality for search feature
            },
          ),
          IconButton(
            icon: const Icon(Icons.shopping_bag_outlined, color: Colors.black),
            onPressed: () {
              // Navigate to shopping cart page
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
<<<<<<< Updated upstream
              Text('Sản phẩm theo hãng',
                  style: GoogleFonts.zillaSlab(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              FutureBuilder<List<ProductModel>>(
                future: APIRepository().fetchProducts(accountID, token), // Update this line with the correct call
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
=======
              const Text('Sản phẩm theo hãng',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ManufacturerLogo(url: 'https://media.discordapp.net/attachments/1089969551896219728/1260673949747118152/image-removebg-preview_1.png?ex=66902d9b&is=668edc1b&hm=5610566e45a1799a1985fcb9d957cdb73d50bc556759e52aeae197d37033d6dd&=&format=webp&quality=lossless&width=65&height=33'),
                  ManufacturerLogo(url: 'https://media.discordapp.net/attachments/1089969551896219728/1260673949352722572/image-removebg-preview_2.png?ex=66902d9b&is=668edc1b&hm=326c1844a14d85ca800ccb7284296b09e9def9d18140fbbb8b3fdb3f64788037&=&format=webp&quality=lossless&width=82&height=40'),
                  ManufacturerLogo(url: 'https://media.discordapp.net/attachments/1089969551896219728/1260673949080223895/image-removebg-preview_3.png?ex=66902d9b&is=668edc1b&hm=ae1d8ab49f0f58433e83cec8872d93dae49e7e2603f39d8fd8864c68908fde6e&=&format=webp&quality=lossless&width=66&height=43'),
                  ManufacturerLogo(url: 'https://media.discordapp.net/attachments/1089969551896219728/1260673948832632896/image-removebg-preview_4.png?ex=66902d9b&is=668edc1b&hm=814c19f747351a9ef0391e58f421f2d8d73980234d24817fc9ff26a9210893c4&=&format=webp&quality=lossless&width=72&height=50'),
                ],
              ),
              const SizedBox(height: 32),
              const Text('Giày phổ biến',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Nike Jordan'),
                  Text('Tất cả', style: TextStyle(color: Colors.blue)),
                ],
              ),
              const SizedBox(height: 8),
              FutureBuilder<List<ProductModel>>(
                future: APIRepository().fetchProducts(accountID, token),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
>>>>>>> Stashed changes
                  } else if (snapshot.hasError) {
                    return Text("Lỗi: ${snapshot.error}");
                  } else if (snapshot.hasData) {
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
<<<<<<< Updated upstream
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.75, // Adjust ratio according to your image and text layout
=======
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.75,
>>>>>>> Stashed changes
                      ),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        var product = snapshot.data![index];
<<<<<<< Updated upstream
                        return ShoeCard(product: product); // Passing product data to ShoeCard
                      },
                    );
                  } else {
                    return Text("Không tìm thấy sản phẩm");
=======
                        return ShoeCard(product: product);
                      },
                    );
                  } else {
                    return const Text("Không tìm thấy sản phẩm");
>>>>>>> Stashed changes
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

<<<<<<< Updated upstream
class ShoeCard extends StatelessWidget {
  final ProductModel product;

  ShoeCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(product.imageURL, fit: BoxFit.cover, height: 120),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.name,
                    style: GoogleFonts.zillaSlab(fontSize: 14, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text('${NumberFormat('###,###.###').format(product.price)} VND',
                    style: GoogleFonts.zenAntiqueSoft(fontSize: 14, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
=======
class ManufacturerLogo extends StatelessWidget {
  final String url;

  ManufacturerLogo({required this.url});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(40)),
        image: DecorationImage(
          image: NetworkImage(url),
          fit: BoxFit.fill,
        ),
>>>>>>> Stashed changes
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
    Widget build(BuildContext context) {
      return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Image.network(widget.product.imageURL,
                      height: 100, fit: BoxFit.fill),
                  Positioned(
                    top: 8,
                    right: 75,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isFavorite = !isFavorite;
                        });
                      },
                      child: AnimatedSwitcher(
                        duration: Duration(milliseconds: 300),
                        transitionBuilder: (Widget child, Animation<double> animation) {
                          return ScaleTransition(scale: animation, child: child);
                        },
                        child: isFavorite
                            ? Icon(Icons.favorite, color: Colors.red, key: ValueKey<bool>(isFavorite))
                            : Icon(Icons.favorite_border, color: Colors.grey, key: ValueKey<bool>(isFavorite)),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(widget.product.name,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text('${NumberFormat.simpleCurrency(locale: 'vi').format(widget.product.price)}',
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              Spacer(),
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
                ),
              ),
            ],
          ),
        ),
      );
  }
}
