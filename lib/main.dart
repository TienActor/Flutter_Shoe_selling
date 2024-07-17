import 'package:flutter/material.dart';
import 'package:tien/Screen/Login/login_screen.dart';


void main() {
  runApp(const MainApp());
}
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
     return  const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '',
      home: LoginScreen(),
    );
  }
}
