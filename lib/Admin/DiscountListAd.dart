import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tien/data/voucher.dart';
import 'EditDiscount.dart';
import 'createVoucher.dart'; // Giả sử đây là trang để tạo mã giảm giá mới

class DiscountPage extends StatefulWidget {
  const DiscountPage({super.key});

  @override
  State<DiscountPage> createState() => _DiscountPageState();
}

class _DiscountPageState extends State<DiscountPage> {
  List<Discount> discounts = [];

  @override
  void initState() {
    super.initState();
    loadDiscounts();
  }

  Future<void> loadDiscounts() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> allDiscounts = prefs.getStringList('discounts') ?? [];
    DateTime now = DateTime.now();
    List<String> activeDiscounts = allDiscounts.where((discount) {
      Discount d = Discount.fromJson(jsonDecode(discount));
      return d.validity.isAfter(now);
    }).toList();

    await prefs.setStringList('discounts', activeDiscounts);
    discounts = activeDiscounts
        .map((discount) => Discount.fromJson(jsonDecode(discount)))
        .toList();
    setState(() {}); // Refresh the UI with active discounts
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mã Giảm Giá'),
        backgroundColor: Colors.red,
      ),
      body: RefreshIndicator(
        onRefresh: loadDiscounts,
        child: ListView.builder(
          itemCount: discounts.length,
          itemBuilder: (BuildContext context, int index) {
            Discount discount = discounts[index];
            return Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                leading: Image.asset('assets/images/discount.png',
                    width: 50, height: 50),
                title: Text(discount.title,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Mã code: ${discount.code}"),
                    Text("Đơn tối thiểu: ${discount.minOrder}"),
                    Text("Chiết khấu: ${discount.discount}%"),
                    Text(
                        "Ngày bắt đầu: ${discount.creationTime.toIso8601String().substring(0, 10)}",
                        style: const TextStyle(color: Colors.green)),
                    Text(
                        "Ngày kết thúc: ${discount.validity.toIso8601String().substring(0, 10)}",
                        style: const TextStyle(color: Colors.red)),
                  ],
                ),
                isThreeLine: true,
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.blue),
                      onPressed: () {
                        Navigator.of(context)
                            .push(
                          MaterialPageRoute(
                              builder: (context) =>
                                  EditVoucherPage(discount: discounts[index])),
                        )
                            .then((value) {
                          if (value == true) {
                            loadDiscounts();
                          }
                        });
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        _showDeleteDialog(index);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
            MaterialPageRoute(builder: (context) => CreateDiscountPage()),
          )
              .then((value) {
            if (value == true) {
              loadDiscounts();
            }
          });
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _deleteDiscount(int index) async {
    // Xóa mã giảm giá từ danh sách
    discounts.removeAt(index);

    // Cập nhật SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    // Lưu lại danh sách sau khi đã xóa
    List<String> updatedDiscounts =
        discounts.map((discount) => jsonEncode(discount.toJson())).toList();
    await prefs.setStringList('discounts', updatedDiscounts);
    // Cập nhật giao diện
    setState(() {});
  }

  void _showDeleteDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Xác nhận'),
          content: Text('Bạn có chắc chắn muốn xóa mã giảm giá này không?'),
          actions: <Widget>[
            TextButton(
              child: Text('Không'),
              onPressed: () {
                Navigator.of(context).pop(); // Đóng dialog mà không làm gì cả
              },
            ),
            TextButton(
              child: Text('Có'),
              onPressed: () {
                Navigator.of(context).pop(); // Đóng dialog và xóa mã giảm giá
                _deleteDiscount(index);
              },
            ),
          ],
        );
      },
    );
  }
}
