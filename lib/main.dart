import 'package:flutter/material.dart';
import 'package:tien/Screen/welcome/intro_page.dart';

import 'Screen/Home/homePage2.dart';

void main() {
  runApp(const MainApp());
}
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
     return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'địt mẹ thằng tiến ngu',
      home: HomePage2(),
    );
  }
}
