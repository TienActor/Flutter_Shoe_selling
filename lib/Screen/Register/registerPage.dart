import 'package:flutter/material.dart';
import 'package:tien/Lab_3/dialog_manager.dart';
import 'package:tien/Screen/Login/login_screen.dart';
import 'package:tien/data/string_extention.dart';
import 'package:tien/page/grid.dart';

class registerPage extends StatefulWidget {
  const registerPage({super.key});

  @override
  State<registerPage> createState() => _registerPageState();
}

class _registerPageState extends State<registerPage> {
  /// thiet lap mau
  static Color _selectedColor = Colors.black;
  static Color _unselectedColor = Colors.grey;

  Color _emailTFColor = _unselectedColor;
  Color _passwordColor = _unselectedColor;

  FocusNode _emailTFColorFocus = FocusNode();
  FocusNode _passwordColorFocus = FocusNode();

  bool _check_value_1 = false;
  bool _check_value_2 = false;
  bool _check_value_3 = false;
  int _gender = 0;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailTFColorFocus.addListener(_onEmailTFFocusChange);
    _passwordColorFocus.addListener(_onPasswordTFFocusChange);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailTFColorFocus.removeListener(_onEmailTFFocusChange);
    _emailTFColorFocus.dispose();

    _passwordColorFocus.removeListener(_onPasswordTFFocusChange);
    _passwordColorFocus.dispose();
  }

  void _onEmailTFFocusChange() {
    setState(() {
      _emailTFColorFocus.hasFocus
          ? _emailTFColor = _selectedColor
          : _emailTFColor = _unselectedColor;
    });
  }

  void _onPasswordTFFocusChange() {
    setState(() {
      _passwordColorFocus.hasFocus
          ? _passwordColor = _selectedColor
          : _passwordColor = _unselectedColor;
    });
  }

  bool _validateInput() {
    if (!_emailController.text.isValidEmail()) {
      DialogManager.showErrorDialog(context, 'Invalid email address!');
      return false;
    }

    if (_passwordController.text.length < 6) {
      DialogManager.showErrorDialog(context, 'Invalid password');
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Second Page"),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.topCenter,
                  child: const Text(
                    "Thông tin người dùng",
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w100,
                        color: Colors.blue),
                  ),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: "Full name", icon: Icon(Icons.person)),
                
                      controller: _nameController,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: "Email or phone",
                      icon: Icon(
                        Icons.mail_outline,
                        color: Colors.black,
                      )),
                      focusNode: _emailTFColorFocus,
                      controller: _emailController,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                      labelText: "Password", icon: Icon(Icons.password)),
                      focusNode: _passwordColorFocus,
                      controller: 
                      _passwordController,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                      labelText: "Confirm Pass",
                      icon: Icon(Icons.password_sharp)),
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  "What is your gender?? ",
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        child: ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      title: const Text("Male"),
                      leading: Transform.translate(
                        offset: const Offset(16, 0),
                        child: Radio(
                          value: 1,
                          groupValue: _gender,
                          onChanged: (value) {
                            setState(() {
                              _gender = value!;
                            });
                          },
                        ),
                      ),
                    )),
                    Expanded(
                        child: ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      title: const Text("Female"),
                      leading: Transform.translate(
                        offset: const Offset(16, 0),
                        child: Radio(
                          value: 2,
                          groupValue: _gender,
                          onChanged: (value) {
                            setState(() {
                              _gender = value!;
                            });
                          },
                        ),
                      ),
                    )),
                    Expanded(
                        child: ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      title: const Text("Other"),
                      leading: Transform.translate(
                        offset: const Offset(16, 0),
                        child: Radio(
                            value: 3,
                            groupValue: _gender,
                            onChanged: (value) {
                              setState(
                                () {
                                  _gender = value!;
                                },
                              );
                            }),
                      ),
                    ))
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text("What is your favorite ??"),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        child: CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: const EdgeInsets.all(0),
                      title: const Text("Music"),
                      value: _check_value_1,
                      onChanged: (value) {
                        setState(() {
                          _check_value_1 = value!;
                        });
                      },
                    )),
                    Expanded(
                        child: CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      title: const Text("Movie"),
                      contentPadding: const EdgeInsets.all(0),
                      value: _check_value_2,
                      onChanged: (value) {
                        setState(() {
                          _check_value_2 = value!;
                        });
                      },
                    )),
                    Expanded(
                        child: CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: const EdgeInsets.all(0),
                      title: const Text("Book"),
                      value: _check_value_3,
                      onChanged: (value) {
                        setState(() {
                          _check_value_3 = value!;
                        });
                      },
                    ))
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 56,
                      width: 199,
                        child: ElevatedButton(
                      onPressed: () {
                        var fullname = _nameController.text;
                        var email = _emailController.text;
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content:
                                    Text("Full name :$fullname\nEmail: $email"),
                              );
                            });
                      },
                      child: const Text("Đăng kí"),
                    )),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                    width: 199,
                    height: 56,
                    child: OutlinedButton(
                        onPressed: () {
                          if(_validateInput()){
                              Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                              ),
                              );
                          }

                      
                        },
                        child: const Text("Đăng nhập")))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
