import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../data/voucher.dart';

class DiscountRepository {
  static const String _storageKey = 'discounts';

  Future<void> saveDiscount(Discount discount) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> allDiscounts = prefs.getStringList(_storageKey) ?? [];
    allDiscounts.add(jsonEncode(discount.toJson()));
    await prefs.setStringList(_storageKey, allDiscounts);
  }

  Future<List<Discount>> loadDiscounts() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> allDiscounts = prefs.getStringList(_storageKey) ?? [];
    return allDiscounts.map((discount) => Discount.fromJson(jsonDecode(discount))).toList();
  }
}
