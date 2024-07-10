import 'package:flutter/material.dart';

class Navbar extends StatelessWidget {
  // Không cần sử dụng const cho constructor ở đây
  Navbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color(0xFF1A2530),
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: const Text('Nam', style: TextStyle(color: Colors.white)),
              accountEmail: const Text('Chào Nam', style: TextStyle(color: Colors.white)),
              currentAccountPicture: CircleAvatar(
                child: Image.asset('assets/images/profile.png'),
              ),
              decoration: BoxDecoration(color: Color(0xFF1A2530)),
            ),
            ListTile(
              leading: Icon(Icons.account_circle, color: Colors.white),
              title: Text('Thông tin cá nhân', style: TextStyle(color: Colors.white)),
              onTap: () => print('Thông tin cá nhân'),
            ),
            ListTile(
              leading: Icon(Icons.home, color: Colors.white),
              title: Text('Trang chủ', style: TextStyle(color: Colors.white)),
              onTap: () => print('Trang chủ'),
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart, color: Colors.white),
              title: Text('Giỏ hàng', style: TextStyle(color: Colors.white)),
              onTap: () => print('Giỏ hàng'),
            ),
            ListTile(
              leading: Icon(Icons.favorite, color: Colors.white),
              title: Text('Yêu thích', style: TextStyle(color: Colors.white)),
              onTap: () => print('Yêu thích'),
            ),
            ListTile(
              leading: Icon(Icons.assignment, color: Colors.white),
              title: Text('Đơn đặt hàng', style: TextStyle(color: Colors.white)),
              onTap: () => print('Đơn đặt hàng'),
            ),
            SizedBox(height: 100),
            Divider(),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.white),
              title: Text('Đăng xuất', style: TextStyle(color: Colors.white)),
              onTap: () => print('Đăng xuất'),
            ),
          ],
        ),
      ),
    );
  }
}
