import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Config/api_urls.dart';
import '../data/category.dart';
import 'BrandsListAd.dart';
import 'DiscountListAd.dart';
import 'ProductListAd.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  int productCount = 0;
  int brandsCount = 0;
  final Dio _dio = Dio();

  @override
  void initState() {
    super.initState();
    fetchProductCount();
    fetchBrandsCount();
  }

  Future<void> fetchBrandsCount() async {
    final token = await _getToken();
    if (token != null) {
      try {
        // Thay đổi URL này tới endpoint cụ thể cho danh mục hoặc thương hiệu
        Response response = await _dio.get(
            ApiUrls.getListByCatId, // URL của bạn có thể khác
            options: Options(headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json'
            }));

        if (response.statusCode == 200) {
          var data = response.data;
          // Giả sử data là một list các danh mục, hãy đảm bảo cách bạn truy cập đến length là đúng
          setState(() {
            brandsCount = data.length;
          });
        } else {
          print(
              'Failed to fetch brands with status code: ${response.statusCode}');
        }
      } catch (e) {
        print('Error fetching brands: $e');
      }
    }
  }

  Future<void> fetchProductCount() async {
    final token = await _getToken();
    if (token != null) {
      try {
        Response response = await _dio.get(
            ApiUrls.getListProduct, // URL của bạn có thể khác
            options: Options(headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json'
            }));

        if (response.statusCode == 200) {
          var data = response.data;
          setState(() {
            productCount = data.length;
          });
        } else {
          print(
              'Failed to fetch products with status code: ${response.statusCode}');
        }
      } catch (e) {
        print('Error fetching products: $e');
      }
    }
  }

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> _refreshDashboard() async {
    await fetchProductCount();
    // Add any other fetch methods for other dashboard items here if necessary
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('Dashboard'),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshDashboard,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(), // Ensure scrollability
          child: Column(
            children: [
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true, // Use it inside Scroll view
                physics:
                    NeverScrollableScrollPhysics(), // to disable GridView's scrolling
                children: [
                  DashboardTileWithImage(
                    title: 'Người dùng',
                    value: '',
                    imagePath:
                        'assets/images/user.png', // Ensure the image is in assets
                    onTap: () async {
                      final token = await _getToken();
                      if (token != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductListScreen(
                                token: token, accountID: 'Tie2023'),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                'Authentication token is not available. Please login again.')));
                      }
                    },
                  ),
                  DashboardTileWithImage(
                    title: 'Thương hiệu',
                    value: brandsCount.toString(),
                    imagePath:
                        'assets/images/brands.png', // Đảm bảo hình ảnh có sẵn trong assets
                    onTap: () async {
                      final token = await _getToken();
                      if (token != null) {
                        // Sử dụng Navigator.push và chờ đợi người dùng trở lại
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                BrandsPage(token: token, accountID: 'Tie2023'),
                          ),
                        );
                        // Sau khi trở lại, làm mới số lượng thương hiệu
                        await fetchBrandsCount();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                'Authentication token is not available. Please login again.')));
                      }
                    },
                  ),
                  DashboardTileWithImage(
                    title: 'Sản phẩm',
                    value: productCount.toString(),
                    imagePath:
                        'assets/images/product.png', // Ensure the image is in assets
                    onTap: () async {
                      final token = await _getToken();
                      if (token != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductListScreen(
                                token: token, accountID: 'Tie2023'),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                'Authentication token is not available. Please login again.')));
                      }
                    },
                  ),
                  DashboardTileWithImage(
                    title: 'Mã giảm giá',
                    value: '0',
                    imagePath:
                        'assets/images/discount.png', // Ensure the image is in assets
                    onTap: () async {
                      final token = await _getToken();
                      if (token != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DiscountPage(),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                'Authentication token is not available. Please login again.')));
                      }
                    },
                  ),
                  DashboardTile(title: 'Đơn hàng', value: '11'),
                  DashboardTile(title: 'Completed Order', value: '12'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DashboardTileWithImage extends StatelessWidget {
  final String title;
  final String value;
  final VoidCallback onTap;
  final String imagePath;

  const DashboardTileWithImage({
    Key? key,
    required this.title,
    required this.value,
    required this.onTap,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imagePath, width: 200, height: 100),
            SizedBox(height: 8),
            Text(title,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            Text(value, style: TextStyle(fontSize: 20, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}

class DashboardTile extends StatelessWidget {
  final String title;
  final String value;
  final VoidCallback? onTap;

  const DashboardTile({
    Key? key,
    required this.title,
    required this.value,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.all(8),
        color: Colors.pink[100],
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(value,
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.red)),
              Text(title,
                  style: const TextStyle(fontSize: 18, color: Colors.red)),
            ],
          ),
        ),
      ),
    );
  }
}
