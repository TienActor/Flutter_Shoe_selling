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
    return  Center(

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
          child: GridView.builder(
              itemCount: lstProduct.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8),
              itemBuilder: (context, index) {
                return itemGridView(lstProduct[index]);
              }),
        ),
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
            NumberFormat('Price:###,###,###').format(productModel.price),
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
}
