import 'package:flutter/material.dart';
import '../Screen/Login/login_screen.dart';
class AdminHome extends StatefulWidget {
  const AdminHome({super.key});
  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trang Quản Trị'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Xin chào, Admin',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              const CircleAvatar(
                radius: 80,
                backgroundImage: AssetImage('assets/images/avatar.png'),
              ),
              const SizedBox(height: 50),
              // Nút "Quản lý khách hàng"
              ElevatedButton.icon(
                onPressed: () {
                  // Xử lý khi nhấn nút
                },
                icon: const Icon(Icons.people, size: 30), // Icon người dùng
                label: const Text('Quản lý khách hàng', style: TextStyle(fontSize: 20)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
              ),
              const SizedBox(height: 20), // Khoảng cách giữa các nút
              // Nút "Quản lý sản phẩm"
              ElevatedButton.icon(
                onPressed: () {
                  // Xử lý khi nhấn nút
                },
                icon: const Icon(Icons.shopping_cart, size: 30), // Icon giỏ hàng
                label: const Text('Quản lý sản phẩm', style: TextStyle(fontSize: 20)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Nút "Quản lý đơn hàng"
              ElevatedButton.icon(
                onPressed: () {
                  // Xử lý khi nhấn nút
                },
                icon: const Icon(Icons.list_alt, size: 30), // Icon danh sách
                label: const Text('Quản lý đơn hàng', style: TextStyle(fontSize: 20)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
