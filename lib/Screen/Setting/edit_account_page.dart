
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tien/Screen/Setting/edit_componet.dart';

class EditAccountScreen extends StatefulWidget {
  const EditAccountScreen({super.key});

  @override
  State<EditAccountScreen> createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  String gender = "Nam";

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
        title:  const Text(
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
                      "https://teddy.vn/wp-content/uploads/2023/05/gau-bong-lena-mu-lotso-3.jpg",
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
              const EditItem(
                title: "idNumber",
                widget: Text("114"),
              ),
              const SizedBox(height: 40),
                const EditItem(
                title: "accountId",
                widget: Text("Tie2023"),
              ),
              const SizedBox(height: 40),
                const EditItem(
                title: "fullName",
                widget: Text("Nguyễn Nhật Tiến"),
              ),
              const SizedBox(height: 40),
                const EditItem(
                title: "phoneNumber",
                widget: Text("0741258963"),
              ),
              const SizedBox(height: 40),
               const EditItem(
                title: "birthDay",
                widget: Text("11/11/2011"),
              ),
              const SizedBox(height: 40),

                const EditItem(
                title: "gender",
                widget: Text("Nam"),
              ),
              const SizedBox(height: 40),
                const EditItem(
                title: "schoolYear",
                widget: Text("2021"),
              ),
              const SizedBox(height: 40),
                const EditItem(
                title: "schoolKey",
                widget: Text("K27"),
              ),
              const SizedBox(height: 40),
              const EditItem(
                widget: TextField(),
                title: "Age",
              ),
              const SizedBox(height: 40),
              const EditItem(
                widget: TextField(),
                title: "Email",
              ),
            ],
          ),
        ),
      ),
    );
  }
}