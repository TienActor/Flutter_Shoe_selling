import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/model.dart';
import '../Login/login_page.dart';
import '../components/custom_dialog.dart';
import '../components/custom_textfield.dart';
import '../components/have_account.dart';
import '../../Config/api_urls.dart';
import 'package:intl/intl.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _accIdController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _numberIdController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _schoolYearController = TextEditingController();
  final TextEditingController _schoolKeyController = TextEditingController();

  final SignupModel _model = SignupModel();
  final APIRepository _apiRepository = APIRepository();

  @override
  void dispose() {
    _accIdController.dispose();
    _passController.dispose();
    _confirmPassController.dispose();
    _fullNameController.dispose();
    _numberIdController.dispose();
    _phoneNumberController.dispose();
    _genderController.dispose();
    _dobController.dispose();
    _schoolYearController.dispose();
    _schoolKeyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
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
                          builder: (context) => const LoginPage()),
                    );
                  },
                ),
              ),
              const SizedBox(height: 30),
              Text(
                'Tạo tài khoản!',
                textAlign: TextAlign.center,
                style: GoogleFonts.pacifico(
                  color: Colors.black,
                  fontSize: 30,
                  letterSpacing: 0,
                  fontWeight: FontWeight.normal,
                  height: 1.6,
                ),
              ),
              Text(
                'Cùng nhau tạo tài khoản!',
                textAlign: TextAlign.center,
                style: GoogleFonts.aBeeZee(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 48),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    CustomTextField(
                      labelText: 'Account ID',
                      controller: _accIdController,
                      keyboardType: TextInputType.text,
                      prefixIcon: Icons.person,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập Account ID';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        _model.accountID = value;
                      },
                    ),
                    CustomTextField(
                      labelText: 'Mật khẩu',
                      controller: _passController,
                      isPassword: true,
                      prefixIcon: Icons.lock,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập mật khẩu';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        _model.password = value;
                      },
                    ),
                    CustomTextField(
                      labelText: 'Xác nhận mật khẩu',
                      controller: _confirmPassController,
                      isPassword: true,
                      prefixIcon: Icons.lock,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng xác nhận mật khẩu';
                        }
                        if (value != _model.password) {
                          return 'Mật khẩu không khớp';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        _model.confirmpass = value;
                      },
                    ),
                    CustomTextField(
                      labelText: 'Họ và tên',
                      controller: _fullNameController,
                      keyboardType: TextInputType.text,
                      prefixIcon: Icons.person,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập họ và tên';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        _model.fullname = value;
                      },
                    ),
                    CustomTextField(
                      labelText: 'NumberID',
                      controller: _numberIdController,
                      keyboardType: TextInputType.number,
                      prefixIcon: Icons.badge,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập NumberID';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        _model.numberID = value;
                      },
                    ),
                    CustomTextField(
                      labelText: 'Số điện thoại',
                      controller: _phoneNumberController,
                      keyboardType: TextInputType.phone,
                      prefixIcon: Icons.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập số điện thoại';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        _model.phonenumber = value;
                      },
                    ),
                    CustomTextField(
                      labelText: 'Giới tính',
                      controller: _genderController,
                      keyboardType: TextInputType.text,
                      prefixIcon: Icons.male,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập giới tính';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        _model.gender = value;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: GestureDetector(
                        onTap: () => _selectDate(context),
                        child: AbsorbPointer(
                          child: TextFormField(
                            controller: _dobController,
                            decoration: InputDecoration(
                              labelText: 'Ngày sinh',
                              prefixIcon: const Icon(Icons.calendar_today),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Vui lòng chọn ngày sinh';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                    CustomTextField(
                      labelText: 'Năm học',
                      controller: _schoolYearController,
                      keyboardType: TextInputType.text,
                      prefixIcon: Icons.school,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập năm học';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        _model.schoolYear = value;
                      },
                    ),
                    CustomTextField(
                      labelText: 'Khóa',
                      controller: _schoolKeyController,
                      keyboardType: TextInputType.text,
                      prefixIcon: Icons.key,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập Khóa của bạn';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        _model.schoolKey = value;
                      },
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: _signup,
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('ĐĂNG KÝ',
                          style: TextStyle(letterSpacing: 4)),
                    ),
                    const SizedBox(height: 16),
                    AlreadyHaveAnAccountCheck(
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _dobController.text = DateFormat('dd/MM/yyyy').format(picked);
        _model.birthday = _dobController.text;
      });
    }
  }

  Future<void> _signup() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final result = await _apiRepository.signup(_model);
      if (result["success"]) {
        if (mounted) {
          CustomDialog(
            context: context,
            message: "ĐĂNG KÝ THÀNH CÔNG",
            durationTimes: 1,
            borderRadius: 90.0,
            textStyle:
                GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 14),
            backgroundColor: Colors.white,
          ).show();
        }
        await Future.delayed(const Duration(seconds: 2), () {
          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
            );
          }
        });
      } else {
        if (mounted) {
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
}
