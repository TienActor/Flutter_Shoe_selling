import 'package:flutter/material.dart';
import 'package:tien/Screen/Setting/setting_page.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color(0xFF1A2530),  // Set background color to black
        child: ListView(
          
          children: [
            UserAccountsDrawerHeader(
              accountName: const Text('Nam', style: TextStyle(color: Colors.white)), // White text color
              accountEmail: const Text('Chào Nam', style: TextStyle(color: Colors.white)), // White text color
              currentAccountPicture: CircleAvatar(
                child: Image.asset('assets/images/profile.png'),
              ),
              decoration: BoxDecoration(color: Color(0xFF1A2530)), // Ensure the header background is black
            ),
            ListTile(
              leading: Icon(Icons.account_circle, color: Colors.white), // White icon color
              title: Text('Thông tin cá nhân', style: TextStyle(color: Colors.white)), // White text color
              onTap: () => print('Thông tin cá nhân'),
            ),
            ListTile(
              leading: Icon(Icons.home, color: Colors.white), // White icon color
              title: Text('Trang chủ', style: TextStyle(color: Colors.white)), // White text color
              onTap: () => print('Trang chủ'),
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart, color: Colors.white), // White icon color
              title: Text('Giỏ hàng', style: TextStyle(color: Colors.white)), // White text color
              onTap: () => print('Giỏ hàng'),
            ),
            ListTile(
              leading: Icon(Icons.favorite, color: Colors.white), // White icon color
              title: Text('Yêu thích', style: TextStyle(color: Colors.white)), // White text color
              onTap: () => print('Yêu thích'),
            ),
            ListTile(
              leading: Icon(Icons.assignment, color: Colors.white), // White icon color
              title: Text('Đơn đặt hàng', style: TextStyle(color: Colors.white)), // White text color
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> SettingPage()));
              },
            ),
            SizedBox(height: 100),
            Divider(),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.white), // White icon color
              title: Text('Đăng xuất', style: TextStyle(color: Colors.white)), // White text color
              onTap: () => print('Đăng xuất'),
            ),
          ],
        ),
      ),
    );
  }
}