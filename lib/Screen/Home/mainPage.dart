import 'package:flutter/material.dart';

import 'package:tien/Screen/Home/test.dart';
import 'package:tien/Screen/Setting/setting_page.dart';

import '../../data/product.dart';
import '../Favorite/favorite.dart';

class DashBoard extends StatefulWidget {
  final String token; // Make sure to pass the token correctly
  const DashBoard({super.key, required this.token, required accountId});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  List<ProductModel> lstProduct = [];
  int _selectedIndex = 0;
  List<Widget> listBody = [];
  PageController pageController = PageController();

  ProductModel placeholderProduct = ProductModel(
      id: 0,
      name: "Default Product",
      description: "Description",
      imageURL: "http://example.com/default.jpg",
      price: 0.0,
      categoryID: 1,
      categoryName: "Default Category",
      quantity: 1);

  @override
  void initState() {
    super.initState();
    listBody = [
      ShoeStoreHome(
        token: widget.token,
        accountID: 'Tie2023',
      ),
      FavoritePage(accountID: 'Tie2023', token: widget.token),
      SettingPage(
        token: widget.token,
      ),
    ];
  }

  List<Widget> getPages() {
    return [
      ShoeStoreHome(token: widget.token, accountID: 'Tie2023'),
      //CartPage(product: '', token: widget.token),
      FavoritePage(accountID: 'Tie2023', token: widget.token),
      SettingPage(
        token: widget.token,
      ),
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
    List<Widget> pages = getPages();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: PageView(
          controller: pageController,
          onPageChanged: onItemTapped,
          children: pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.price_change), label: "Favorite"),
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
