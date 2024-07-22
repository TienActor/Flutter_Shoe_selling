import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:tien/data/billDetail.dart';
import '../Config/api_urls.dart';
import '../data/bill.dart';

class OrderDetailPage extends StatefulWidget {
  final String billID;

  const OrderDetailPage({Key? key, required this.billID}) : super(key: key);

  @override
  _OrderDetailPageState createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
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

  Future<void> _deleteOrder() async {
    final token = await _getToken();
    if (token != null) {
      try {
        final response = await Dio().delete(
          '${ApiUrls.removeBill}${widget.billID}',
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            },
          ),
        );

        if (response.statusCode == 200) {
          Navigator.pop(context, true);
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Xóa đơn hàng thành công')));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Xóa đơn hàng thất bại')));
        }
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error deleting order: $e')));
      }
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
        backgroundColor: Colors.red,
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

                            // Nút "Xóa Đơn Hàng" được căn giữa
                            Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: Center(
                                child: ElevatedButton(
                                  onPressed: () async {
                                    final confirm = await showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text('Xác nhận xóa'),
                                        content: const Text(
                                            'Bạn có chắc chắn muốn xóa đơn hàng này không?'),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context, false),
                                            child: const Text('Hủy'),
                                          ),
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context, true),
                                            child: const Text('Xóa'),
                                          ),
                                        ],
                                      ),
                                    );
                                    if (confirm == true) {
                                      _deleteOrder();
                                    }
                                  },
                                  child: const Text(
                                    'Xóa Đơn Hàng',
                                    style: TextStyle(
                                      color: Colors
                                          .white, // Explicitly set text color to white
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red, // Button color
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 12),
                                    textStyle: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ),
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
