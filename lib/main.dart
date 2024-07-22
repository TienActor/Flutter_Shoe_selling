import 'package:flutter/material.dart';
import 'package:tien/Screen/Cart/userprovider.dart';
import 'package:tien/Screen/Login/login_page.dart';
import 'package:provider/provider.dart';
import 'package:tien/Screen/Cart/cartProvider.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartProvider()),
         ChangeNotifierProvider(create: (context) => UserProvider()),
      ],
    child:  MainApp()),
    );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
  