import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tien/Config/voucherJson.dart';
import 'package:tien/data/voucher.dart';
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
    List<String> activeDiscounts = [];

    allDiscounts.forEach((discount) {
      Discount d = Discount.fromJson(jsonDecode(discount));
      if (d.validity.isAfter(now)) {
        activeDiscounts.add(discount);
      }
    });

    // Cập nhật lại danh sách mã giảm giá trong SharedPreferences
    await prefs.setStringList('discounts', activeDiscounts);
    discounts = activeDiscounts.map((discount) => Discount.fromJson(jsonDecode(discount))).toList();
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
        onRefresh: loadDiscounts,  // Kéo xuống để làm mới danh sách
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
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                leading: Image.asset('assets/images/discount.png', width: 50, height: 50),
                title: Text(discount.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(discount.minOrder),
                    Text(discount.discount),
                    Text("Expires on: ${discount.validity.toString()}", style: const TextStyle(color: Colors.grey)),  // Show the validity as a date
                  ],
                ),
                isThreeLine: true,
                trailing: IconButton(
                  icon: const Icon(Icons.arrow_forward_ios),
                  onPressed: () {},
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreateDiscountPage()));
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}
