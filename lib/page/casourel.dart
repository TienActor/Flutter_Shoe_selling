import 'package:flutter/material.dart';
import 'package:tien/Config/const.dart';
import 'package:tien/data/data.dart';
import 'package:tien/data/model.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CasouPage extends StatefulWidget {
  const CasouPage({super.key});

  @override
  State<CasouPage> createState() => _CasouPageState();
}

class _CasouPageState extends State<CasouPage> {
  List<ProductModel> lstProduct = [];

  @override
  void initState() {
    
    super.initState();
    lstProduct = createDataList(10);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: Scaffold(
      appBar: AppBar(
        title: const Text("Casourel view !!!"),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        alignment: Alignment.center,
        child: slide(lstProduct),
      ),
    ));
  }

 Widget slide(List<ProductModel> listProduct) {
  return CarouselSlider(
    options: CarouselOptions(
      autoPlay: true,
      aspectRatio: 2.0,
      enlargeCenterPage: true
    ),
    items: listProduct.map((item) => Container(
      margin: const EdgeInsets.all(5.0),
      child: Stack(
        children: <Widget>[
          Image.asset(
            urlImage + item.img!,
            fit: BoxFit.cover,
            width: 1000.0,
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
                  end: Alignment.topCenter
                )
              ),
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            )
          ),
          Positioned(
            bottom: 10.0, // Đặt vị trí text
            left: 20.0,
            child: Text(
              item.name!,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold
              )
            )
          )
        ],
      ),
    )).toList(),
  );
}

}
