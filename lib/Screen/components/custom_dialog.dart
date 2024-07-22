import 'package:flutter/material.dart';

class CustomDialog {
  final BuildContext context;
  final String message;
  final int durationTimes; // Thời gian hiển thị
  final double borderRadius; // Độ bo góc
  final TextStyle? textStyle; // Kiểu chữ cho thông điệp
  final Color? backgroundColor; // Màu nền

  CustomDialog({
    required this.context,
    required this.message,
    required this.durationTimes,
    this.textStyle,
    this.backgroundColor,
    required this.borderRadius,
  });

  void show() {
    showDialog(
      context: context,
      barrierDismissible: true, //TODO: chạm ngoài để tắt dialog
      builder: (BuildContext context) {
        Future.delayed(Duration(seconds: durationTimes), () {
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop();
          }
        });
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min, // Kích thước nhỏ nhất theo trục dọc
            mainAxisAlignment:
                MainAxisAlignment.center, // Căn giữa theo trục dọc
            crossAxisAlignment:
                CrossAxisAlignment.center, // Căn giữa theo trục ngang
            children: [
              Text(
                message.toUpperCase(),
                style: textStyle,
              ),
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          backgroundColor: backgroundColor,
        );
      },
    );
  }
}
