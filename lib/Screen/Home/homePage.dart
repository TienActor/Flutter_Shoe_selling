import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tien/Config/const.dart';
import 'package:tien/data/data.dart';
import 'package:tien/data/model.dart';
import 'package:tien/page/casourel.dart';
import 'package:tien/page/list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ProductModel> lstProduct = [];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: body(),
    );
  }

  @override
  void initState() {
    super.initState();
    lstProduct = createDataList(10);
  }

  Widget body() {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Trang chủ"),
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => const MyList()));
                },
                icon: const Icon(Icons.wifi_tethering_error_rounded_outlined)),
            IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CasouPage()));
                },
                icon: const Icon(Icons.list))
          ],
        ),
        body: Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.center,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                   height: 160,
                  child: slide(lstProduct),
                 
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: GridView.builder(
                      itemCount: lstProduct.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8),
                      itemBuilder: (context, index) {
                        return itemGridView(lstProduct[index]);
                      }),
                ),
              ],
            )),
      ),
    );
  }

  Widget itemGridView(ProductModel productModel) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: Colors.grey.shade200),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(
            urlImage + productModel.img!,
            width: 80,
            height: 80,
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.error),
          ),
          Text(
            productModel.name ?? '',
            textAlign: TextAlign.center,
          ),
          Text(
            NumberFormat('Giá:###,###,###').format(productModel.price),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.red.shade200),
          ),
          Text(
            productModel.des!,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14, color: Colors.black),
          )
        ],
      ),
    );
  }

  Widget slide(List<ProductModel> listProduct) {
    return CarouselSlider(
      options: CarouselOptions(
          autoPlay: true, aspectRatio: 2.0, enlargeCenterPage: true),
      items: listProduct
          .map((item) => Container(
                margin: const EdgeInsets.all(5.0),
                child: Stack(
                  children: <Widget>[
                    Image.asset(
                      urlImage + item.img!,
                      fit: BoxFit.fill,
                      width: 700.0,
                    ),
                    Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          height: 60.0, // Cố định chiều cao cho phần gradient
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                Color.fromARGB(255, 14, 15, 86), // Màu xanh đậm
                                Color(0x00004D40) // Màu xanh đậm trong suốt
                              ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter)),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                        )),
                    Positioned(
                        bottom: 10.0, // Đặt vị trí text
                        left: 20.0,
                        child: Text(item.name!,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold)))
                  ],
                ),
              ))
          .toList(),
    );
  }
}
