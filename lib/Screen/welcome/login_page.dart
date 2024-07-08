import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:show_hide_password/show_hide_password.dart';
import 'package:input_form_field/input_form_field.dart';
import 'signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
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
              const SizedBox(height: 100),
              Text(
                'Xin Chào!',
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
                'Chào mừng trở lại. Shop rất nhớ bạn!',
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
                    InputFormField(
                      textEditingController: emailController,
                      labelText: "Email",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      borderRadius: BorderRadius.circular(8),
                      errorPadding: const EdgeInsets.only(left: 10, top: 10),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Nhập email của bạn.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    ShowHidePassword(
                      passwordField: (bool hidePassword) {
                        return InputFormField(
                          textEditingController: passwordController,
                          obscureText: hidePassword,
                          labelText: "Mật khẩu",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          borderRadius: BorderRadius.circular(8),
                          errorPadding:
                              const EdgeInsets.only(left: 10, top: 10),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Nhập mật khẩu của bạn.';
                            }
                            return null;
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          //
                        },
                        child: const Text('Quên mật khẩu?'),
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          //
                        }
                      },
                      child: const Text('Đăng nhập'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignupPage()),
                  );
                },
                child: const Text('Không có tài khoản? Đăng ký ngay!'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
