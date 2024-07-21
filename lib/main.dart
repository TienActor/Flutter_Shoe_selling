import 'package:flutter/material.dart';
<<<<<<< Updated upstream
import 'package:tien/Mainpage.dart';
import 'package:tien/Screen/welcome/intro_page.dart';
=======
import 'package:tien/Screen/Login/login_page.dart';
import 'package:provider/provider.dart';
import 'package:tien/Screen/Cart/cart_provider.dart';
>>>>>>> Stashed changes

<<<<<<< Updated upstream
=======
import 'page/grid.dart';

>>>>>>> Stashed changes
void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: const MainApp(),
    ),
  );
}
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
     return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'địt mẹ thằng tiến ngu',
      home: Mainpage(),
    );
  }
}
