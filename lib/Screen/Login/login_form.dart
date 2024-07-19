import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../Admin/homepageAd.dart';
import '../../Config/api_urls.dart';
import '../../Config/const.dart';
import '../../data/model.dart';
import '../../page/grid.dart';
import '../Register/register_page.dart';
import '../components/already_have_an_account_check.dart';

class LoginFrom extends StatefulWidget {
  const LoginFrom({super.key});

  @override
  State<LoginFrom> createState() => _LoginFromState();
}

class _LoginFromState extends State<LoginFrom> {
  final _accIdController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final LoginModel _model = LoginModel();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            onSaved: (value) => _model.accountID = value!,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Vui lòng nhập AccountID';
              }
              return null;
            },
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            controller: _accIdController,
            decoration: const InputDecoration(
              hintText: "Tài khoản",
              prefixIcon: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.person),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              onSaved: (value) => _model.password = value!,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Vui lòng nhập mật khẩu';
                }
                return null;
              },
              textInputAction: TextInputAction.done,
              controller: _passwordController,
              obscureText: true,
              cursorColor: kPrimaryColor,
              decoration: const InputDecoration(
                hintText: "Mật khẩu",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          ElevatedButton(
            onPressed: () {
              _login();
            },
            child: Text(
              "Đăng nhập".toUpperCase(),
            ),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const RegisterPage();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> _login() async {
  if (_formKey.currentState!.validate()) {
    _formKey.currentState!.save();

    var request = http.MultipartRequest('POST', Uri.parse(ApiUrls.login));
    request.fields['AccountID'] = _model.accountID!;
    request.fields['Password'] = _model.password!;

    try {
      var response = await request.send();
      final res = await http.Response.fromStream(response);

      if (res.statusCode == 200) {
        log('Login successful');

        var data = jsonDecode(res.body);
        if (data['success'] == true) {
          var token = data['data']['token'];
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', token);

          // Check if the login credentials are for the admin
          if (_model.accountID == "Tie2023" && _model.password == "Tient3st") {
            // Redirect to AdminHome if credentials match
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => AdminHome(), 
              ),
            );
          } else {
            // Redirect to regular user dashboard
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => DashBoard(token: token),
              ),
            );
          }
        }
      } else {
        log('Failed to log in with status code: ${res.statusCode}');
        log('Response body: ${res.body}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed: ${res.body}')),
        );
      }
    } catch (e) {
      log('Error sending request: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login error: $e')),
      );
    }
  }
}

}
