import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateDiscountPage extends StatefulWidget {
  const CreateDiscountPage({super.key});

  @override
  State<CreateDiscountPage> createState() => _CreateDiscountPageState();
}

class _CreateDiscountPageState extends State<CreateDiscountPage> {
  final _formKey = GlobalKey<FormState>();
  DateTime? _startDate;
  DateTime? _expiryDate;
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _minOrderController = TextEditingController();
  final TextEditingController _discountController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tạo Mã Giảm Giá Mới'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _codeController,
                decoration: const InputDecoration(labelText: 'Code'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Code không được để trống';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Tiêu đề'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Tiêu đề không được để trống';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _minOrderController,
                decoration: const InputDecoration(labelText: 'Đơn tối thiểu'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Giá trị không được để trống';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Vui lòng nhập số';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _discountController,
                decoration: const InputDecoration(labelText: 'Chiết khấu (%)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Chiết khấu không được để trống';
                  }
                  double? discount = double.tryParse(value);
                  if (discount == null || discount < 0 || discount > 100) {
                    return 'Chiết khấu phải là một số từ 0 đến 100';
                  }
                  return null;
                },
              ),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                title: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Chọn ngày bắt đầu'),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: Text(_startDate == null
                      ? 'Chưa chọn ngày'
                      : 'Ngày bắt đầu: ${_startDate!.toIso8601String().substring(0, 10)}'),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () => _pickDate(context, true),
                ),
              ),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                title: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Chọn ngày hết hạn'),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: Text(_expiryDate == null
                      ? 'Chưa chọn ngày'
                      : 'Ngày hết hạn: ${_expiryDate!.toIso8601String().substring(0, 10)}'),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () => _pickDate(context, false),
                ),
              ),
              TextFormField(
                controller: _quantityController,
                decoration: const InputDecoration(labelText: 'Số lượng'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _saveDiscount();
                  }
                },
                child: const Text('Lưu Mã Giảm Giá'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
        } else {
          _expiryDate = picked;
        }
      });
    }
  }

  void _saveDiscount() async {
    if (!_formKey.currentState!.validate()) {
      return; // Đừng lưu nếu form không hợp lệ
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> discounts = prefs.getStringList('discounts') ?? [];
    Map<String, dynamic> newDiscount = {
      'code': _codeController.text,
      'title': _titleController.text,
      'minOrder': _minOrderController.text,
      'discount': _discountController.text,
      'creationTime': _startDate?.toIso8601String(),
      'validity': _expiryDate?.toIso8601String(),
      'quantity': int.parse(_quantityController.text),
    };

    discounts.add(jsonEncode(newDiscount));
    await prefs.setStringList('discounts', discounts);
    Navigator.pop(context, true); // Trả về true để thông báo cần load lại dữ liệu
  }
}
