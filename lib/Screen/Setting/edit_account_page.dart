import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tien/Screen/Setting/setting_page.dart';
import '../../Config/api_urls.dart';
import '../components/custom_dialog.dart';
import '../components/custom_textfield.dart';
import 'package:intl/intl.dart';

class EditAccountScreen extends StatefulWidget {
  const EditAccountScreen({Key? key}) : super(key: key);

  @override
  State<EditAccountScreen> createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _numberIdController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _schoolYearController = TextEditingController();
  final TextEditingController _schoolKeyController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SettingPage(
                                  token: '',
                                )),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  'Chỉnh sửa tài khoản!',
                  style: GoogleFonts.pacifico(fontSize: 30),
                ),
                const SizedBox(height: 48),
                // Define all custom text fields
                CustomTextField(
                  labelText: 'Họ và tên',
                  controller: _fullNameController,
                  prefixIcon: Icons.person,
                ),
                CustomTextField(
                  labelText: 'NumberID',
                  controller: _numberIdController,
                  keyboardType: TextInputType.text,
                  prefixIcon: Icons.badge,
                ),
                CustomTextField(
                  labelText: 'Số điện thoại',
                  controller: _phoneNumberController,
                  keyboardType: TextInputType.phone,
                  prefixIcon: Icons.phone,
                ),
                CustomTextField(
                  labelText: 'Giới tính',
                  controller: _genderController,
                  prefixIcon: Icons.male,
                ),
                GestureDetector(
                  onTap: () => _selectDate(context),
                  child: AbsorbPointer(
                    child: CustomTextField(
                      labelText: 'Ngày sinh',
                      controller: _dobController,
                      prefixIcon: Icons.calendar_today,
                    ),
                  ),
                ),
                CustomTextField(
                  labelText: 'Năm học',
                  controller: _schoolYearController,
                  prefixIcon: Icons.school,
                ),
                CustomTextField(
                  labelText: 'Khóa',
                  controller: _schoolKeyController,
                  prefixIcon: Icons.key,
                ),
                CustomTextField(
                  labelText: 'Image URL',
                  controller: _imageUrlController,
                  prefixIcon: Icons.image,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _updateProfile,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('CẬP NHẬT'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      _dobController.text = DateFormat('dd/MM/yyyy').format(picked);
    }
  }

  Future<void> _updateProfile() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Get the saved token from SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('token') ?? '';

      if (token.isEmpty) {
        CustomDialog(
          context: context,
          message: "Không tìm thấy token. Xin hãy đăng nhập lại.",
          durationTimes: 2,
          borderRadius: 30.0,
          textStyle:
              GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 14),
          backgroundColor: Colors.white,
        ).show();
        return;
      }

      // Prepare data for the API call
      Map<String, dynamic> result = await _apiRepository.updateProfile(
          _numberIdController.text,
          _fullNameController.text,
          _phoneNumberController.text,
          _genderController.text,
          _dobController.text,
          _schoolYearController.text,
          _schoolKeyController.text,
          _imageUrlController.text,
          token // Passing the token as an argument
          );

      // Handle the response
      if (result["success"]) {
        CustomDialog(
          context: context,
          message: "CẬP NHẬT THÀNH CÔNG",
          durationTimes: 1,
          borderRadius: 90.0,
          textStyle:
              GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 14),
          backgroundColor: Colors.white,
        ).show();
        await Future.delayed(const Duration(seconds: 2), () {
          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const SettingPage(
                        token: '',
                      )),
            );
          }
        });
      } else {
        CustomDialog(
          context: context,
          message: result['message'],
          durationTimes: 2,
          borderRadius: 30.0,
          textStyle:
              GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 14),
          backgroundColor: Colors.white,
        ).show();
      }
    }
  }
}
