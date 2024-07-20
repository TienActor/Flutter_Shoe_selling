import 'package:flutter/material.dart';
import 'package:tien/Screen/Setting/setting_page.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color(0xFF1A2530),  // Set background color to black
        child: ListView(
          
          children: [
            UserAccountsDrawerHeader(
              accountName: const Text('Nam', style: TextStyle(color: Colors.white)), // White text color
              accountEmail: const Text('Chào Nam', style: TextStyle(color: Colors.white)), // White text color
              currentAccountPicture: CircleAvatar(
                child: Image.asset('assets/images/profile.png'),
              ),
              decoration: const BoxDecoration(color: Color(0xFF1A2530)), // Ensure the header background is black
            ),
            ListTile(
              leading: const Icon(Icons.account_circle, color: Colors.white), // White icon color
              title: const Text('Thông tin cá nhân', style: TextStyle(color: Colors.white)), // White text color
              onTap: () => print('Thông tin cá nhân'),
            ),
            ListTile(
              leading: const Icon(Icons.home, color: Colors.white), // White icon color
              title: const Text('Trang chủ', style: TextStyle(color: Colors.white)), // White text color
              onTap: () => print('Trang chủ'),
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart, color: Colors.white), // White icon color
              title: const Text('Giỏ hàng', style: TextStyle(color: Colors.white)), // White text color
              onTap: () => print('Giỏ hàng'),
            ),
            ListTile(
              leading: const Icon(Icons.favorite, color: Colors.white), // White icon color
              title: const Text('Yêu thích', style: TextStyle(color: Colors.white)), // White text color
              onTap: () => print('Yêu thích'),
            ),
            ListTile(
              leading: const Icon(Icons.assignment, color: Colors.white), // White icon color
              title: const Text('Đơn đặt hàng', style: TextStyle(color: Colors.white)), // White text color
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const SettingPage()));
              },
            ),
            const SizedBox(height: 100),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.white), // White icon color
              title: const Text('Đăng xuất', style: TextStyle(color: Colors.white)), // White text color
              onTap: () => print('Đăng xuất'),
            ),
          ],
        ),
      ),
    );
  }
}