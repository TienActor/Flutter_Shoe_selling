import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import '../../data/orderInfo.dart';

class OrderStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/order_info.json');
  }

  Future<List<OrderInfo>> readOrders() async {
    try {
      final file = await _localFile;
      if (await file.exists()) {
        final contents = await file.readAsString();
        final jsonData = json.decode(contents);
        return (jsonData['orders'] as List)
            .map((order) => OrderInfo.fromJson(order))
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<File> writeOrder(OrderInfo order) async {
    final file = await _localFile;
    List<OrderInfo> orders = await readOrders();
    orders.add(order);
    return file.writeAsString(
        json.encode({'orders': orders.map((e) => e.toJson()).toList()}));
  }
}
