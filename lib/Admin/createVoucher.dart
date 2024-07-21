import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tien/data/voucher.dart';

class CreateDiscountPage extends StatefulWidget {
  const CreateDiscountPage({super.key});

  @override
  State<CreateDiscountPage> createState() => _CreateDiscountPageState();
}

class _CreateDiscountPageState extends State<CreateDiscountPage> {
  DateTime? _expiryDate;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _minOrderController = TextEditingController();
  final TextEditingController _discountController = TextEditingController();
  final TextEditingController _validityHoursController =
      TextEditingController(); // Để nhập số giờ
  final TextEditingController _validityDaysController =
      TextEditingController(); // Để nhập số ngày
  final TextEditingController _quantityController =
      TextEditingController(); // Để nhập số lượng

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tạo Mã Giảm Giá Mới'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Tiêu đề',
              ),
            ),
            TextField(
              controller: _minOrderController,
              decoration: const InputDecoration(
                labelText: 'Đơn tối thiểu',
              ),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _discountController,
              decoration: const InputDecoration(
                labelText: 'Chiết khấu',
              ),
            ),
            TextField(
              controller: _validityHoursController,
              decoration: const InputDecoration(
                labelText: 'Thời gian hiệu lực (giờ)',
              ),
              keyboardType: TextInputType.number,
            ),
            ListTile(
              title: Text('Thời gian hiệu lực'),
              subtitle: Text(_expiryDate == null
                  ? 'Chọn ngày'
                  : 'Hết hạn: ${_expiryDate!.toIso8601String().substring(0, 10)}'),
              trailing: IconButton(
                icon: Icon(Icons.calendar_today),
                onPressed: _pickExpiryDate,
              ),
            ),
            TextField(
              controller: _quantityController,
              decoration: const InputDecoration(
                labelText: 'Số lượng',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveDiscount,
              child: const Text('Lưu Mã Giảm Giá'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickExpiryDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _expiryDate) {
      setState(() {
        _expiryDate = picked;
      });
    }
  }

  void _saveDiscount() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> discounts = prefs.getStringList('discounts') ?? [];

    Map<String, dynamic> newDiscount = {
      'title': _titleController.text,
      'minOrder': _minOrderController.text,
      'discount': _discountController.text,
      'validity': _expiryDate?.toIso8601String(),
      'creationTime': DateTime.now().toIso8601String(),
      'quantity': int.parse(
          _quantityController.text.isEmpty ? "0" : _quantityController.text),
      'isActive': true,
    };

    discounts.add(jsonEncode(newDiscount));
    await prefs.setStringList('discounts', discounts);
    Navigator.pop(context);
  }
}
