import 'package:flutter/material.dart';
import 'package:tien/TH/register_page.dart';

class Facebooklogin extends StatefulWidget {
  const Facebooklogin({super.key});

  @override
  State<Facebooklogin> createState() => _FacebookloginState();
}

class _FacebookloginState extends State<Facebooklogin> {
  void gotoRegisterPage( ) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterPage()));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.arrow_back_ios),
          // title: const Text("Tien nguyen"),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  'https://th.bing.com/th/id/OIP.9I1wDqOf4jDbY5JEcNeq7QHaF2?rs=1&pid=ImgDetMain',
                  width: 90,
                  height: 90,
                ),
                const SizedBox(
                  height: 30,
                ),
                const TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: ("Email or username")),
                ),
                const SizedBox(
                  height: 30,
                ),
                const TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: ("Password")),
                  obscureText: true,
                ),
                const SizedBox(
                  height: 30,
                ),
                TextButton(
                    style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all(Colors.black),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.blue)),
                    onPressed: () {},
                    child: const Text("Login")),
                const SizedBox(
                  height: 30,
                ),
                TextButton(
                    onPressed:  gotoRegisterPage,
                    child: const Text("You forget password !!!")),
                const SizedBox(
                  height: 90,
                ),
                TextButton(
                    onPressed: () {}, child: const Text("Create new account ??"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
