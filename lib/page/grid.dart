import 'package:flutter/material.dart';


import '../Screen/Home/test.dart';

class DashBoard extends StatefulWidget {
  final String token;
  const DashBoard({required this.token, super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  int _selectedIndex = 0;
  late List<Widget> _pages;
  PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    // Thiết lập các trang sẽ được hiển thị trong PageView
    _pages = [
      ShoeStoreHome(token: widget.token, accountID: 'Tie2023'),
      // Assuming FavoritePage, CartPage, and SettingsPage don't need token
      // const CartPage(),
      // const FavoritePage(),
      // const SettingsPage(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: _pages,
        onPageChanged: _onItemTapped,
        physics: const NeverScrollableScrollPhysics(), // Ngăn không cho người dùng vuốt để chuyển trang
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
