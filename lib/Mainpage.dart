import 'package:flutter/material.dart';
import 'package:tien/navbar.dart';

class Mainpage extends StatefulWidget {
  @override
  _MainpageState createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Navbar(),
      appBar: AppBar(
        title: Text('navigation'), backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Text('MainPage'),
      ),
    );
  }
}

