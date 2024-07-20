
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tien/Screen/Setting/Edit_account_page.dart';
import 'package:tien/Screen/Setting/edit_componet.dart';

import '../../data/user.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool isDarkMode = false;
  User user = User.userEmpty();
  getDataUser() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    String strUser = pref.getString('user')!;

    user = User.fromJson(jsonDecode(strUser));
    setState(() {
      
    });  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: IconButton(
      //     onPressed: () {},
      //     icon: const Icon(Ionicons.chevron_back_outline),
      //   ),
      //   leadingWidth: 80,
      // ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Cài đặt",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                "Tài khoản",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    Image.network("https://teddy.vn/wp-content/uploads/2023/05/gau-bong-lena-mu-lotso-3.jpg", width: 70, height: 70),
                    const SizedBox(width: 20),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Nguyễn Nhật Tiến",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Tie2023",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        )
                      ],
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EditAccountScreen(),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                "Cài đặt",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              // const SizedBox(height: 20),
              // SettingItem(
              //   title: "Ngôn ngữ",
              //   icon: Ionicons.earth,
              //   bgColor: Colors.orange.shade100,
              //   iconColor: Colors.orange,
              //   value: "English",
              //   onTap: () {},
              // ),
              // const SizedBox(height: 20),
              // SettingItem(
              //   title: "Thông báo",
              //   icon: Ionicons.notifications,
              //   bgColor: Colors.blue.shade100,
              //   iconColor: Colors.blue,
              //   onTap: () {},
              // ),
              const SizedBox(height: 20),
              SettingSwitch(
                title: "Dark Mode",
                icon: Ionicons.earth,
                bgColor: Colors.purple.shade100,
                iconColor: Colors.purple,
                value: isDarkMode,
                onTap: (value) {
                  setState(() {
                    isDarkMode = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              SettingItem(
                title: "Cài đặt thông báo",
                icon: Ionicons.nuclear,
                bgColor: Colors.red.shade100,
                iconColor: Colors.red,
                onTap: () {},
              ),
              const SizedBox(height: 20),
              SettingItem(
                title: "Địa chỉ giao hàng",
                icon: Ionicons.nuclear,
                bgColor: Colors.red.shade100,
                iconColor: Colors.red,
                onTap: () {},
              ),
              const SizedBox(height: 20),
              SettingItem(
                title: "Phương thức thanh toán ",
                icon: Ionicons.nuclear,
                bgColor: Colors.red.shade100,
                iconColor: Colors.red,
                onTap: () {},
              ),
              const SizedBox(height:150),
               const Divider(color: Colors.black,),
              
            //   user.accountId==''? const SizedBox():ListTile(leading: Icon(Icons.exit_to_app),
            //   title: Text('Logout'),onTap: () {
            // Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
            //     //logOut(context);
            //   },)
            ],
          ),
        ),
      ),
    );
  }
}