import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tien/Config/api_urls.dart';
import 'package:tien/Screen/Cart/order_detail.dart';
import 'package:tien/data/bill.dart';

class OrderHistoryPage extends StatefulWidget {
  final String token;

  OrderHistoryPage({required this.token});

  @override
  _OrderHistoryPageState createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  late Future<List<BillModel>> futureOrders;

  List<BillModel> _bills = [];
  bool _isLoading = true;
  String _error = '';

  @override
  void initState() {
    super.initState();
    _fetchOrders();
  }

  Future<void> _fetchOrders() async {
    try {
      final token = await _getToken();
      if (token != null) {
        final response = await Dio().get(
          ApiUrls.getBillHistory,
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            },
          ),
        );

        setState(() {
          _bills = (response.data as List)
              .map((json) => BillModel.fromJson(json))
              .toList();
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Failed to load orders.';
        _isLoading = false;
      });
    }
  }

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lịch sử đơn hàng'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: _isLoading
          ? const Center(child: const CircularProgressIndicator())
          : _error.isNotEmpty
              ? Center(child: Text(_error))
              : RefreshIndicator(
                  onRefresh: _fetchOrders,
                  child: ListView.builder(
                    itemCount: _bills.length,
                    itemBuilder: (context, index) {
                      final bill = _bills[index];
                      return Card(
                        margin: const EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: Icon(Icons.receipt,
                              color: Theme.of(context).colorScheme.secondary),
                          title: Text(bill.fullName),
                          subtitle: Text(
                            '${bill.dateCreated} - ${NumberFormat('###,###,###').format(bill.total)} VND',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios),
                          onTap: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OrderDetailPage(
                                  billID: bill.id,
                                  token: widget.token,
                                ),
                              ),
                            );
                            if (result == true) {
                              _fetchOrders(); // Reload data if an order has been deleted
                            }
                          },
                        ),
                      );
                    },
                  ),
                ),
    );
  }
}
