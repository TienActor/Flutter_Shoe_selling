import 'package:flutter/material.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(title: const Text("Thuc hanh buoi 1")),
          body: const Center(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(),
            ),
          )),
    );
  }
}
