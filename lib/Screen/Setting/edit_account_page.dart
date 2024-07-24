import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tien/Config/api_urls.dart';
import 'package:tien/Screen/Setting/edit_account.dart';
import 'package:tien/Screen/Setting/edit_componet.dart';
import 'package:tien/data/user.dart';

class AccountInfoScreen extends StatefulWidget {
  final String token;
 const AccountInfoScreen({Key? key,required this.token}) : super(key: key);

  @override
  State<AccountInfoScreen> createState() => _AccountInfoScreenState();
}

class _AccountInfoScreenState extends State<AccountInfoScreen> {
  User? user;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _numberIdController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _schoolYearController = TextEditingController();
  final TextEditingController _schoolKeyController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  final APIRepository _apiRepository = APIRepository();

  @override
  void dispose() {
    _fullNameController.dispose();
    _numberIdController.dispose();
    _phoneNumberController.dispose();
    _genderController.dispose();
    _dobController.dispose();
    _schoolYearController.dispose();
    _schoolKeyController.dispose();
    _imageUrlController.dispose();
    super.dispose();
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
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> EditAccountScreen(token:widget.token ,)));
              },
              style: IconButton.styleFrom(
                backgroundColor: Colors.lightBlueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                fixedSize: const Size(60, 50),
                elevation: 3,
              ),
              icon: const Icon(Icons.admin_panel_settings_outlined, color: Colors.white),
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
        
            ],
          ),
        ),
      ),
    );
  }
}
