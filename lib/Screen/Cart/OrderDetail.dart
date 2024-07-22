import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tien/Config/api_urls.dart';
import 'package:tien/data/billDetail.dart';

class OrderDetailPage extends StatefulWidget {
  final String billID;
  final String token;

  OrderDetailPage({required this.billID, required this.token});

  @override
  _OrderDetailPageState createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  late Future<List<BillDetailModel>> futureOrderDetails;

 List<BillDetailModel> _details = [];
  bool _isLoading = true;
  String _error = '';

  @override
  void initState() {
    super.initState();
   _fetchDetails();
  }


Future<void> _fetchDetails() async {
    try {
      final token = await _getToken();
      if (token != null) {
        final response = await Dio().post(
          '${ApiUrls.getBillById}${widget.billID}',
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            },
          ),
        );

        setState(() {
          _details = (response.data as List)
              .map((json) => BillDetailModel.fromJson(json))
              .toList();
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Failed to load order details: $e';
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
        title: const Text('Chi Tiết Đơn Hàng'),
        backgroundColor: Colors.blueAccent,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error.isNotEmpty
              ? Center(child: Text(_error))
              : ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: _details.length,
                  itemBuilder: (context, index) {
                    final detail = _details[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: detail.imageURL.isNotEmpty
                                  ? Image.network(
                                      detail.imageURL,
                                      width: 150,
                                      height: 150,
                                      fit: BoxFit.cover,
                                    )
                                  : Container(
                                      width: 150,
                                      height: 150,
                                      color: Colors.grey[200],
                                      child:
                                          const Icon(Icons.image_not_supported),
                                    ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              detail.productName,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Giá: ${NumberFormat('###,###,###').format(detail.price)} VND',
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.red),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Số lượng: ${detail.count}',
                              style: const TextStyle(fontSize: 18),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Tổng cộng: ${NumberFormat('###,###,###').format(detail.total)} VND',
                              style: const TextStyle(fontSize: 18),
                            ),

                           
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
