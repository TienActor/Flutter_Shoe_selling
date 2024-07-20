import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Config/api_urls.dart';
import 'ProductListAd.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  State<AdminHome> createState() => _AdminHomeState();
}
class _AdminHomeState extends State<AdminHome> {
  int productCount = 0;
  final Dio _dio = Dio();  

  @override
  void initState() {
    super.initState();
    fetchProductCount();
  }

  Future<void> fetchProductCount() async {
    final token = await _getToken();
    if (token != null) {
      try {
        Response response = await _dio.get(
          ApiUrls.getListProduct,  // URL của bạn có thể khác
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json'
            }
          )
        );

        if (response.statusCode == 200) {
          var data = response.data;
          setState(() {
            productCount = data.length;  
          });
        } else {
          print('Failed to fetch products with status code: ${response.statusCode}');
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('Dashboard'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              children: [
                DashboardTile(title: 'Users', value: '35'),
                DashboardTile(title: 'Categories', value: '4'),
                DashboardTile(
                  title: 'Products',
                  value: productCount.toString(),
                  onTap: () async {
                    final token = await _getToken();
                    if (token != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductListScreen(token: token, accountID: 'Tie2023'),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Authentication token is not available. Please login again.'))
                      );
                    }
                  },
                ),
                DashboardTile(title: 'Earning', value: '2325'),
                DashboardTile(title: 'Pending Order', value: '11'),
                DashboardTile(title: 'Completed Order', value: '12'),
              ],
            ),
          ),
        ],
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
              Text(
                value,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.red),
              ),
              Text(
                title,
                style: const TextStyle(fontSize: 18, color: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}