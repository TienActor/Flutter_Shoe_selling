import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import '../Config/api_urls.dart';
import '../data/bill.dart';
import 'OrderDetailAd.dart';

class OrdersPage extends StatefulWidget {
  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
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
        title: Text('Danh sách đơn hàng'),
        backgroundColor: Colors.red,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _error.isNotEmpty
              ? Center(child: Text(_error))
              : RefreshIndicator(
                  onRefresh: _fetchOrders,
                  child: ListView.builder(
                    itemCount: _bills.length,
                    itemBuilder: (context, index) {
                      final bill = _bills[index];
                      return Card(
                        margin: EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: Icon(Icons.receipt, color: Theme.of(context).colorScheme.secondary),
                          title: Text(bill.fullName),
                          subtitle: Text(
                            '${bill.dateCreated} - ${NumberFormat('###,###,###').format(bill.total)} VND',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                          trailing: Icon(Icons.arrow_forward_ios),
                          onTap: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OrderDetailPage(billID: bill.id),
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
