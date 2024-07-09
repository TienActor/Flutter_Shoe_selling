import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:show_hide_password/show_hide_password.dart';
import 'login_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    usernameController.dispose();
    passwordController.dispose();
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
                    Navigator.pop(context);
                  },
                ),
              ),
              const SizedBox(height: 60),
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
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.blue, width: 2),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Nhập email của bạn.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        labelText: 'Tên',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.blue, width: 2),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Nhập tên của bạn.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    ShowHidePassword(
                      passwordField: (bool hidePassword) {
                        return TextFormField(
                          controller: passwordController,
                          obscureText: hidePassword,
                          decoration: InputDecoration(
                            labelText: 'Mật khẩu',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 2),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Nhập mật khẩu của bạn.';
                            }
                            return null;
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          // Implement registration functionality
                        }
                      },
                      child: const Text('Đăng ký'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      child: const Text('Đã có tài khoản? Đăng nhập ngay!'),
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
}
