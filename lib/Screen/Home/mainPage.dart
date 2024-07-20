import 'package:flutter/material.dart';

import 'package:tien/Screen/Cart/CartPage.dart';
import 'package:tien/Screen/Favorite/favorite.dart';
import 'package:tien/Screen/Home/test.dart';
import 'package:tien/Screen/Setting/setting_page.dart';


import '../../data/product.dart';


class DashBoard extends StatefulWidget {
 final String token;  // Make sure to pass the token correctly
  const DashBoard({ super.key, required this.token, required accountId});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  List<ProductModel> lstProduct = [];
  int _selectedIndex = 0;
  List<Widget> listBody = [];
  PageController pageController = PageController();



  @override
  void initState() {
    super.initState();
    listBody = [
       ShoeStoreHome(token: widget.token, accountID: 'Tie2023',),
      const CartPage(),
      FavoritePage(accountID:'Tie2023',token: widget.token),
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
        body: PageView(
          controller: pageController,
          onPageChanged: onItemTapped,
          children: listBody,
        ),
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
}
