import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tien/page/grid.dart';
import '../data/data.dart';
import '../data/model.dart';
import '../Config/const.dart';
import 'dart:core';

class MyList extends StatefulWidget {
  const MyList({super.key});

  @override
  State<MyList> createState() => _MyListState();
}

class _MyListState extends State<MyList> {
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
          leading: IconButton(
            onPressed: () {
              // Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>const DashBoard(token: null,) ));
            },
            icon: const Icon(Icons.arrow_back_outlined),
          ),
          title: const Text("Danh sách sản phẩm"),
        ),
        body: Container(
          padding: const EdgeInsets.all(16),
          alignment: Alignment.center,
          child: ListView.builder(
              itemCount: lstProduct.length,
              itemBuilder: (context, index) {
                return itemListView(lstProduct[index]);
              }),
        ),
      ),
    );
  }
  // create sub widget
  Widget itemListView(ProductModel productModel) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(color: Colors.grey.shade200),
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        Image.asset(
          urlImage + productModel.img!,
          height: 80,
          width: 80,
          errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.back_hand),
        ),
        const SizedBox(
          height: 16,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              productModel.name ?? '',
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w200),
            ),
            Text(
              "Price: ${NumberFormat('###,###.###').format(productModel.price)}",
              style: const TextStyle(fontSize: 14, color: Colors.red),
            ),
            Text(
              productModel.des!,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            )
          ],
        )
      ]),
    );
  }
}
