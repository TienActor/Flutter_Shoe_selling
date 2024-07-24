import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tien/Config/api_urls.dart';
import 'package:tien/Screen/Login/login_page.dart';
import 'package:tien/Screen/Setting/Edit_account_page.dart';
import 'package:tien/Screen/Setting/edit_componet.dart';
import '../../data/user.dart';
import 'AddressSetting.dart';

class SettingPage extends StatefulWidget {
  final String token;
  const SettingPage({super.key, required this.token});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class SettingItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color bgColor;
  final Color iconColor;
  final VoidCallback onTap;
  final Widget? trailing;

  const SettingItem({
    Key? key,
    required this.title,
    required this.icon,
    required this.bgColor,
    required this.iconColor,
    required this.onTap,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(icon, color: iconColor, size: 24),
            const SizedBox(width: 20),
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const Spacer(),
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );
  }
}

class _SettingPageState extends State<SettingPage> {
  bool isDarkMode = false;
  String? userName;
  String? userProfileImage;
  late SharedPreferences prefs;
String? selectedAddress;
  @override
  void initState() {
    super.initState();
    _loadUserData();
    _loadUserAddress();
  }
 Future<void> _loadUserAddress() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedAddress = prefs.getString('address');
    });
  }

  Future<void> _saveUserAddress(String address) async {
    prefs = await SharedPreferences.getInstance();
    await prefs.setString('address', address);
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
 void _navigateToAddressPage() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddressListPage(token: widget.token),
      ),
    );

    if (result != null && result is String) {
      setState(() {
        selectedAddress = result;
      });
      await _saveUserAddress(result);
      print("Địa chỉ được chọn: $selectedAddress");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cài đặt'),
        leading: IconButton(
          icon: const Icon(Ionicons.chevron_back_outline),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
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
                      ClipOval(
                        child: Image.network(userProfileImage!,
                            width: 70, height: 70, fit: BoxFit.cover),
                      )
                    else
                      const Icon(Icons.account_circle, size: 70),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userName ?? 'Tên người dùng',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          userName ?? '',
                          style: const TextStyle(
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
                            builder: (context) =>  AccountInfoScreen(token: widget.token,),
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
              // SettingSwitch(
              //   title: "Dark Mode",
              //   icon: Ionicons.earth,
              //   bgColor: Colors.purple.shade100,
              //   iconColor: Colors.purple,
              //   value: isDarkMode,
              //   onTap: (value) {
              //     setState(() {
              //       isDarkMode = value;
              //     });
              //   },
              // ),
              const SizedBox(height: 20),
              SettingItem(
                title: "Chỉnh sửa tài khoản ",
                icon: Ionicons.notifications,
                bgColor: Colors.blue.shade100,
                iconColor: Colors.blue,
                onTap: () {},
              ),
              const SizedBox(height: 20),
              SettingItem(
                title: "Địa chỉ giao hàng",
                icon: Ionicons.location_outline,
                bgColor: Colors.green.shade100,
                iconColor: Colors.green,
                onTap: _navigateToAddressPage,
                trailing: selectedAddress != null ? Text(selectedAddress!) : null,
              ),
              // const SizedBox(height: 20),
              // SettingItem(
              //   title: "Phương thức thanh toán",
              //   icon: Ionicons.card_outline,
              //   bgColor: Colors.orange.shade100,
              //   iconColor: Colors.orange,
              //   onTap: () {},
              // ),
              const SizedBox(height: 120),
              const Divider(
                color: Colors.black,
              ),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: _showLogoutConfirmationDialog,
                  child: const Text('Đăng xuất'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, // Text color
                    backgroundColor: Colors.blue, // Button color
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
