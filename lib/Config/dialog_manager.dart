import 'package:flutter/material.dart';
import 'package:tien/Screen/Register/register_page.dart';


class DialogManager {
  static Future<void> showErrorDialog(
      BuildContext context, String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('My app'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static void showSnackBar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: Colors.blue.withOpacity(.8),
      behavior: SnackBarBehavior.floating,
      action: SnackBarAction(label: 'Ok', onPressed: (){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const RegisterPage()));
      }),
    ));
  }
}
