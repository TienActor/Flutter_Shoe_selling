import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tien/Config/api_urls.dart';
import 'package:tien/Screen/Cart/cartPage.dart';
import 'package:tien/Screen/Cart/orderHistory.dart';
import 'package:tien/Screen/Home/mainPage.dart';
import 'package:tien/Screen/Login/login_page.dart';
import 'package:tien/Screen/Setting/edit_account_page.dart';
import 'package:tien/Screen/Setting/setting_page.dart';

import '../../data/user.dart';

class Navbar extends StatefulWidget {
  final String token;
  const Navbar({super.key,required this.token});

  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  String? userName;
  String? userProfileImage;
  String? accountId;
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token != null) {
      APIRepository apiRepository = APIRepository();
      try {
        User user = await apiRepository.currentUser(token);
        print('User data: ${user.fullName}, ${user.imageURL},${user.accountId}'); // Thông báo gỡ lỗi
        setState(() {
          userName = user.fullName;
          userProfileImage = user.imageURL;
          accountId = user.accountId;
        });
      } catch (e) {
        print('Không thể tải dữ liệu người dùng: $e');
      }
    }
  }

  void _showLogoutConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Xác nhận đăng xuất'),
          content: const Text('Bạn có muốn đăng xuất không?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Không'),
              onPressed: () {
                Navigator.of(context).pop(); // Đóng hộp thoại
              },
            ),
            TextButton(
              child: const Text('Có'),
              onPressed: () async {
               
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color(0xFF1A2530),  // Set background color to black
    child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(userName ?? '', style: const TextStyle(color: Colors.white)), // Màu chữ trắng
              accountEmail: Text(userName != null ? 'Chào $userName' : '', style: const TextStyle(color: Colors.white)), // Màu chữ trắng
              currentAccountPicture: userProfileImage != null && userProfileImage!.isNotEmpty
                  ? CircleAvatar(
                      backgroundImage: NetworkImage(userProfileImage!),
                    )
                  : CircleAvatar(
                      backgroundColor: Colors.black,
                      child: Icon(Icons.person, color: Colors.white),
                    ),
              decoration: const BoxDecoration(color: Color(0xFF1A2530)), // Đảm bảo nền của header là màu đen
            ),
            ListTile(
              leading: const Icon(Icons.account_circle, color: Colors.white), // White icon color
              title: const Text('Thông tin cá nhân', style: TextStyle(color: Colors.white)), // White text color
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> AccountInfoScreen(token: widget.token,)));
              }
            ),
            ListTile(
              leading: const Icon(Icons.home, color: Colors.white), // White icon color
              title: const Text('Trang chủ', style: TextStyle(color: Colors.white)), // White text color
              onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context)=> DashBoard(token: widget.token, accountId: accountId)));},
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart, color: Colors.white), // White icon color
              title: const Text('Giỏ hàng', style: TextStyle(color: Colors.white)), // White text color
              onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context)=> CartDetail(token: widget.token)));}
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
               Navigator.push(context, MaterialPageRoute(builder: (context)=>  OrderHistoryPage(token: widget.token,)));
              },
            ),
            const SizedBox(height: 100),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.white), // Màu icon trắng
              title: const Text('Đăng xuất', style: TextStyle(color: Colors.white)), // Màu chữ trắng
              onTap: _showLogoutConfirmationDialog,
            ),
          ],
        ),
      ),
    );
  }
}