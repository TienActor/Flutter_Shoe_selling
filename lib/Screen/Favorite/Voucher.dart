import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tien/data/voucher.dart';

class VoucherPage extends StatefulWidget {
  const VoucherPage({super.key});

  @override
  State<VoucherPage> createState() => _DiscountPageState();
}

class _DiscountPageState extends State<VoucherPage> {
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
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
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
                    width: 80, height: 250),
                title: Text(discount.title,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Mã code: ${discount.code}"),
                    Text("Đơn tối thiểu: ${discount.minOrder}"),
                    Text("Chiết khấu: ${discount.discount}%"),
                    Text("Số lượng mã: ${discount.quantity}"),
                    Text(
                        "Ngày bắt đầu: ${discount.creationTime.toIso8601String().substring(0, 10)}",
                        style: const TextStyle(color: Colors.green)),
                    Text(
                        "Ngày kết thúc: ${discount.validity.toIso8601String().substring(0, 10)}",
                        style: const TextStyle(color: Colors.red)),
                  ],
                ),
                isThreeLine: true,
              ),
            );
          },
        ),
      ),
    );
  }

}
