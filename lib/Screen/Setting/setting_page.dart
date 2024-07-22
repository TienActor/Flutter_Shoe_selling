import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tien/Config/api_urls.dart';
import 'package:tien/Screen/Login/login_page.dart';
import 'package:tien/Screen/Setting/Edit_account_page.dart';
import 'package:tien/Screen/Setting/edit_componet.dart';
import '../../data/user.dart';

class SettingPage extends StatefulWidget {
  final String token;
  const SettingPage({super.key, required this.token});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool isDarkMode = false;
  String? userName;
  String? userProfileImage;
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token != null) {
      APIRepository apiRepository = APIRepository();
      try {
        User user = await apiRepository.currentUser(token);
        print(
            'User data: ${user.fullName}, ${user.imageURL}'); // Thông báo gỡ lỗi
        setState(() {
          userName = user.fullName;
          userProfileImage = user.imageURL;
        });
      } catch (e) {
        print('Không thể tải dữ liệu người dùng: $e');
      }
    }
  }

  void _showLogoutConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Xác nhận đăng xuất'),
          content: const Text('Bạn có muốn đăng xuất không?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Không'),
              onPressed: () {
                Navigator.of(context).pop(); // Đóng hộp thoại
              },
            ),
            TextButton(
              child: const Text('Có'),
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.clear(); // Xóa thông tin đăng nhập đã lưu
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
          ],
        );
      },
    );
  }

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
                    if (userProfileImage != null)
                      Image.network(userProfileImage!, width: 70, height: 70)
                    else
                      Icon(Icons.account_circle, size: 70),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userName ?? 'Tên người dùng',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          userName ?? '',
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
              const SizedBox(height: 150),
              const Divider(
                color: Colors.black,
              ),
              ElevatedButton(onPressed: _showLogoutConfirmationDialog, child:  Text('Đăng xuất '),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, // Text color
                  backgroundColor: Colors.blue, // Button color
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),))

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
