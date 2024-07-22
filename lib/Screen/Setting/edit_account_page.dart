import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tien/Config/api_urls.dart';
import 'package:tien/Screen/Setting/edit_componet.dart';
import 'package:tien/data/user.dart';

class EditAccountScreen extends StatefulWidget {
  const EditAccountScreen({super.key});

  @override
  State<EditAccountScreen> createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  User? user;
  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token != null) {
      APIRepository apiRepository = APIRepository();
      try {
        User userData = await apiRepository.currentUser(token);
        print(
            'User data: ${userData.fullName}, ${userData.imageURL}'); // Thông báo gỡ lỗi
        setState(() {
          user = userData;
        });
      } catch (e) {
        print('Không thể tải dữ liệu người dùng: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Ionicons.chevron_back_outline),
        ),
        leadingWidth: 80,
        title: const Text(
          "Tài khoản",
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {},
              style: IconButton.styleFrom(
                backgroundColor: Colors.lightBlueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                fixedSize: const Size(60, 50),
                elevation: 3,
              ),
              icon: const Icon(Ionicons.checkmark, color: Colors.white),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              EditItem(
                title: "Hình ảnh",
                widget: Column(
                  children: [
                    Image.network(
                      user?.imageURL ?? '',
                      height: 100,
                      width: 100,
                    ),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.lightBlueAccent,
                      ),
                      child: const Text("Cập nhật hình"),
                    )
                  ],
                ),
              ),
              EditItem(
                title: "idNumber",
                widget: Text(user?.idNumber ?? ''),
              ),
              const SizedBox(height: 40),
              EditItem(
                title: "accountId",
                widget: Text(user?.accountId ?? ''),
              ),
              const SizedBox(height: 40),
              EditItem(
                title: "fullName",
                widget: Text(user?.fullName ?? ''),
              ),
              const SizedBox(height: 40),
              EditItem(
                title: "phoneNumber",
                widget: Text(user?.phoneNumber ?? ''),
              ),
              const SizedBox(height: 40),
              EditItem(
                title: "birthDay",
                widget: Text(user?.birthDay ?? ''),
              ),
              const SizedBox(height: 40),
              EditItem(
                title: "gender",
                widget: Text(user?.gender ?? ''),
              ),
              const SizedBox(height: 40),
              EditItem(
                title: "schoolYear",
                widget: Text(user?.schoolYear ?? ''),
              ),
              const SizedBox(height: 40),
              EditItem(
                title: "schoolKey",
                widget: Text(user?.schoolKey ?? ''),
              ),
              const SizedBox(height: 40),
              // const EditItem(
              //   widget: TextField(),
              //   title: "Age",
              // ),
              // const SizedBox(height: 40),
              // const EditItem(
              //   widget: TextField(),
              //   title: "Email",
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
