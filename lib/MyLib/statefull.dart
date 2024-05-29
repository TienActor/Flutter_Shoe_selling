import 'package:flutter/material.dart';
import 'package:tien/page/grid.dart';


class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  bool _check_value_1 = false;
  bool _check_value_2 = false;
  bool _check_value_3 = false;
  int _gender = 0;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
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
                  "User infomation",
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w100,
                      color: Colors.blue),
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(
                    labelText: "Full name", icon: Icon(Icons.person)),
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
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                    labelText: "Password", icon: Icon(Icons.password)),
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
                children: [
                  Expanded(
                      child: ElevatedButton(
                    onPressed: () {
                      var fullname = _nameController.text;
                      var email = _emailController.text;
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Text("Full name :$fullname\nEmail: $email"),
                            );
                          });            
                    },
                    child: const Text("Register"),
                  )),
                ],
              ),
              const SizedBox(height: 16,),
              SizedBox(width: 109,height: 56,child: OutlinedButton(onPressed: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const GridPage()) );
              }, child: const Text("Login")))
            ],
          ),
        ),
      ),
    );
  }
}
