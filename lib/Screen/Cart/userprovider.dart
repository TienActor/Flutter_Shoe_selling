import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../../data/user.dart';

class UserProvider with ChangeNotifier {
  User _user = User.userEmpty();

  User get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

UserAddress get userAddress {
    return UserAddress(addresses: _user.addresses); // Giả sử _user có thuộc tính addresses
  }
  void updateUser({
    String? email,
    String? phone,
    String? address,
    String? paymentMethod,
  }) {
    if (email != null) _user.accountId = email;
    if (phone != null) _user.phoneNumber = phone;
    // Handle address and payment method updates if necessary
    notifyListeners();
  }
  Future<UserData> loadUserData() async {
  final jsonString = await rootBundle.loadString('assets/user_data.json');
  final jsonResponse = json.decode(jsonString);
  return UserData.fromJson(jsonResponse);
}
}
