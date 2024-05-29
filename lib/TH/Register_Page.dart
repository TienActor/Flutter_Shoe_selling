import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(leading: const Text("data"),),
        body: Center(
       child: Padding(padding: const EdgeInsets.all(20.0),
       child: Column(
          children: [Image.network("https://i.pinimg.com/originals/14/5e/fa/145efacc84e0766735c86b7489692c7b.png",width: 700,height: 70,)],
       ),
       ),
        ),
      ),
    );
  }
}