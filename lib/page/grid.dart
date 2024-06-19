import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tien/Config/const.dart';
import 'package:tien/Screen/Cart/CartPage.dart';
import 'package:tien/Screen/Favorite/favorite.dart';
import 'package:tien/Screen/Home/homePage.dart';
import 'package:tien/Screen/Setting/setting_page.dart';
import 'package:tien/data/data.dart';
import 'package:tien/data/model.dart';
import 'package:tien/page/casourel.dart';
import 'package:tien/page/list.dart';

class GridPage extends StatefulWidget {
  final token;
  const GridPage({@required this.token, super.key});

  @override
  State<GridPage> createState() => _GridPageState();
}

class _GridPageState extends State<GridPage> {
  List<ProductModel> lstProduct = [];
  int _selectedIndex = 0;
  List<Widget> listBody = [];
  PageController pageController = PageController();

  // void _loadWidget(int index) {
  //   var nameWidget = "Home";
  //   switch (index) {
  //     case 0:
  //       nameWidget = "Home";
  //       break;
  //     case 1:
  //       nameWidget = "Favorite";
  //       break;
  //     case 2:
  //       nameWidget = "Love";
  //       break;
  //     case 3:
  //       {
  //         nameWidget = "Setting";
  //         Navigator.push(context, MaterialPageRoute(builder: (context)=> const SettingPage()));
  //         break;
  //       }

  //     default:
  //       nameWidget = "None";
  //       break;
  //   }
  // }

  @override
  void initState() {
    super.initState();
    lstProduct = createDataList(10);
    listBody = [
      const HomePage(),
      const CartPage(),
      const FavoritePage(),
      const SettingPage(),
    ];
  }

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // appBar: AppBar(
        //   title: const Text("Trang chủ"),
        //   actions: <Widget>[
        //     IconButton(
        //         onPressed: () {
        //           Navigator.pushReplacement(context,
        //               MaterialPageRoute(builder: (context) => const MyList()));
        //         },
        //         icon: const Icon(Icons.wifi_tethering_error_rounded_outlined)),
        //     IconButton(
        //         onPressed: () {
        //           Navigator.pushReplacement(
        //               context,
        //               MaterialPageRoute(
        //                   builder: (context) => const CasouPage()));
        //         },
        //         icon: const Icon(Icons.list))
        //   ],
        // ),
        body: PageView(
          controller: pageController,
          onPageChanged: onItemTapped,
          children: listBody,
        ),
        // body:
        //  PageView(
        //    padding: const EdgeInsets.all(8.0),
        //    child: Container(
        //     padding: const EdgeInsets.all(16),
        //     alignment: Alignment.center,
        //     child: GridView.builder(
        //         itemCount: lstProduct.length,
        //         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //             crossAxisCount: 2,
        //             childAspectRatio: 1,
        //             crossAxisSpacing: 8,
        //             mainAxisSpacing: 8),
        //         itemBuilder: (context, index) {
        //           return itemGridView(lstProduct[index]);
        //         }),

        //            ),
        //  ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.filter_vintage_outlined), label: "Favorite"),
            BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Love"),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: "Setting")
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[600],
          unselectedItemColor: Colors.grey,
          onTap: onItemTapped,
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
