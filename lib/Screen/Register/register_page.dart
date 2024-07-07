import 'package:flutter/material.dart';
import 'package:tien/Config/dialog_manager.dart';
import 'package:tien/Screen/Login/login_screen.dart';
import 'package:tien/data/string_extention.dart';
import 'package:tien/page/grid.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  /// thiết lập dropdown option
  String dropMenuGender = "Nam";
  String dropMenuSchYear = "2020";
  String dropMenuSchKey = "K25";
  // thiết lập code lấy dữ liệu ngày ,v.v
   final TextEditingController _dateController = TextEditingController();
     int _gender = 0;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  /// thiet lap mau
  static Color selectedColor = Colors.black;
  static Color unselectedColor = Colors.grey;
  Color emailTFColor = unselectedColor;
  Color passwordColor = unselectedColor;
  FocusNode emailTFColorFocus = FocusNode();
  FocusNode passwordColorFocus = FocusNode();


  @override
  void initState() {
    super.initState();
    emailTFColorFocus.addListener(_onEmailTFFocusChange);
    passwordColorFocus.addListener(_onPasswordTFFocusChange);
  }

  @override
  void dispose() {
    super.dispose();
    emailTFColorFocus.removeListener(_onEmailTFFocusChange);
    emailTFColorFocus.dispose();

    passwordColorFocus.removeListener(_onPasswordTFFocusChange);
    passwordColorFocus.dispose();
  }

  void _onEmailTFFocusChange() {
    setState(() {
      emailTFColorFocus.hasFocus
          ? emailTFColor = selectedColor
          : emailTFColor = unselectedColor;
    });
  }

  void _onPasswordTFFocusChange() {
    setState(() {
      passwordColorFocus.hasFocus
          ? passwordColor = selectedColor
          : passwordColor = unselectedColor;
    });
  }

// Khai báo hàm build DropdownButton
  DropdownButton<String> buildDropdownButton(String currentValue,
      List<DropdownMenuItem<String>> items, Function(String?) onChanged) {
    return DropdownButton<String>(
      value: currentValue,
      icon: const Icon(Icons.arrow_drop_down),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: onChanged,
      items: items,
    );
  }

  // hàm cập nhật date picker
  Future<void> _selectDate() async {
    DateTime? picker= await showDatePicker(
        context: context,
        initialDate: DateTime(2005),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));

         if (picker != null) {
    // Format ngày tháng năm
    String formattedDate = "${picker.day}/${picker.month}/${picker.year}";
    setState(() {
      _dateController.text = formattedDate;  // Cập nhật text của controller
    });
  }
  }

  bool _validateInput() {
    if (!_emailController.text.isValidEmail()) {
      DialogManager.showErrorDialog(context, 'Email không hợp lệ!');
      return false;
    }

    if (_passwordController.text.length < 6) {
      DialogManager.showErrorDialog(context, 'Mật khẩu không hợp lệ');
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
          title: const Text("Trang đăng kí"),
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
                      labelText: "Họ và tên", icon: Icon(Icons.person)),
                  controller: _nameController,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: "ID tài khoản",
                      icon: Icon(
                        Icons.mail_outline,
                        color: Colors.black,
                      )),
                  focusNode: emailTFColorFocus,
                  controller: _emailController,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                      labelText: "Mật khẩu", icon: Icon(Icons.password)),
                  focusNode: passwordColorFocus,
                  controller: _passwordController,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                      labelText: "Xác nhận mật khẩu",
                      icon: Icon(Icons.password_sharp)),
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  "Giới tính ? ",
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        child: ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      title: const Text("Nam"),
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
                      title: const Text("Nữ"),
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
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                 TextField(
                  controller: _dateController,
                  decoration: const InputDecoration(
                      labelText: "Ngày sinh",
                      filled: true,
                      prefixIcon: Icon(Icons.calendar_today),
                      enabledBorder:
                          OutlineInputBorder(borderSide: BorderSide.none)),
                  readOnly: true,
                 onTap: (){
                  _selectDate();
                 },
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text("Năm học: "),
                      const SizedBox(width: 10),
                      Expanded(
                        child: buildDropdownButton(dropMenuSchYear, [
                          const DropdownMenuItem(value: "2020", child: Text("Năm 4")),
                          const DropdownMenuItem(value: "2021", child: Text("Năm 3")),
                        ], (newValue) {
                          setState(() {
                            dropMenuSchYear = newValue!;
                          });
                        }),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                          child: Row(
                        children: [
                          const Text("Khóa học"),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: buildDropdownButton(dropMenuSchKey, [
                              const DropdownMenuItem(
                                  value: "K25", child: Text("Khóa 2019")),
                              const DropdownMenuItem(
                                  value: "K26", child: Text("Khóa 2020")),
                              const DropdownMenuItem(
                                  value: "K27", child: Text("Khóa 2021")),
                              const DropdownMenuItem(
                                  value: "K28", child: Text("Khóa 2022")),
                            ], (newValue) {
                              setState(() {
                                dropMenuSchKey = newValue!;
                              });
                            }),
                          )
                        ],
                      ))
                    ]),
                const SizedBox(
                  height: 16,
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
                            if (_validateInput()) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const DashBoard(token: null,),
                                ),
                              );
                            }
                          },
                          child: const Text("Đăng kí tài khoản"),
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
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          );
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
