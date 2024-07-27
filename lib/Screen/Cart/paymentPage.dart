import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tien/Config/api_urls.dart';
import 'package:tien/Screen/Cart/cart_provider.dart';
import 'package:tien/Screen/Cart/orderStorage.dart';
import 'package:tien/Screen/Cart/userprovider.dart';
import 'package:tien/Screen/Home/mainPage.dart';
import '../../data/cart.dart';
import '../../data/cart_item.dart';
import '../../data/user.dart';

class PaymentPage extends StatefulWidget {
  final double totalAmount;
  final double discount;
  final List<CartItem> cartItems;
  // final List<ProductModel> products; // Danh sách sản phẩm trong giỏ hàng
  final String token; // Thêm token
  final UserData userData;

  // ignore: prefer_const_constructors_in_immutables
  PaymentPage(
      {Key? key,
      required this.totalAmount,
      required this.discount,
      required this.cartItems,
      required this.token,
      required this.userData})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  int selectedAddressIndex = 0;
 String selectedPaymentMethod = 'Chuyển khoản ngân hàng';
  final OrderStorage orderStorage = OrderStorage();
  final TextEditingController discountCodeController = TextEditingController();
  double appliedDiscount = 0.0; // Giảm giá áp dụng
  User? user;
List<String> addresses = [];

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _loadAddresses();
  }
  Future<void> _loadAddresses() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      addresses = prefs.getStringList('addresses') ?? [];
    });
  }
  Future<void> _checkout() async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    print("Token: ${widget.token}");

    List<Cart> cartItems = widget.cartItems.map((cartItem) {
      return Cart(productID: cartItem.product.id, count: cartItem.quantity);
    }).toList();

    bool success = await APIRepository().addBill(cartItems, widget.token);
    if (success) {
      Provider.of<CartProvider>(context, listen: false).clearCart();
        
      Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => DashBoard(
        token: widget.token,
        accountId: user.accountId,
      )),
      (Route<dynamic> route) => false,
    ).then((_) {
      // Hiển thị thông báo thành công sau khi đã điều hướng
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Đặt hàng thành công"),
        duration: Duration(seconds: 2),
      ));
    });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Đặt hàng thất bại"),
        duration: Duration(seconds: 2),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    double finalAmount = widget.totalAmount - appliedDiscount;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
        title: const Text('Trang thanh toán'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              buildContactInfoSection(widget.userData),
              const SizedBox(height: 16),
              buildAddressSection(widget.userData),
              const SizedBox(height: 16),
              buildPaymentMethodSection(),
              const SizedBox(height: 16),
              TextField(
                controller: discountCodeController,
                decoration: InputDecoration(
                  labelText: 'Mã giảm giá',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.check),
                    onPressed: () => _applyDiscount(),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              buildTotalSection(
                  widget.totalAmount, appliedDiscount, finalAmount),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _checkout,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: const Text('Thanh toán', style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _applyDiscount() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> discounts = prefs.getStringList('discounts') ?? [];
    String code = discountCodeController.text;

    for (String jsonStr in discounts) {
      Map<String, dynamic> discount = json.decode(jsonStr);
      if (discount['code'] == code &&
          DateTime.parse(discount['validity']).isAfter(DateTime.now()) &&
          discount['quantity'] > 0) {
        // Sử dụng trực tiếp giá trị int
        double discountValue;

        // Kiểm tra kiểu dữ liệu của 'discount' trước khi chuyển đổi
        if (discount['discount'] is String) {
          discountValue = double.parse(discount['discount']);
        } else if (discount['discount'] is int) {
          discountValue = (discount['discount'] as int).toDouble();
        } else {
          discountValue = discount['discount'];
        }

        setState(() {
          appliedDiscount = discountValue;
        });
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Mã giảm giá áp dụng thành công"),
          duration: Duration(seconds: 2),
        ));
        return;
      }
    }

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Mã giảm giá không hợp lệ hoặc đã hết hạn"),
      duration: Duration(seconds: 2),
    ));
  }

  Widget buildContactInfoSection(UserData userData) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             const Text('Thông tin liên lạc', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.people),
                const SizedBox(width: 10,),
                Text(user?.fullName ?? ''),
                const SizedBox(width: 10),
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              children: [

                const Icon(Icons.email),
                const SizedBox(width: 10),
                Text(userData.email),
            
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.phone),
                const SizedBox(width: 10),
               Expanded(child: Text(user?.phoneNumber ?? '')),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAddressSection(UserData userData) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Địa chỉ',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            DropdownButton<int>(
              value: selectedAddressIndex,
              isExpanded: true,
             items: addresses.map<DropdownMenuItem<int>>((String address) {
                return DropdownMenuItem<int>(
                  value: addresses.indexOf(address),
                  child: Text(address),
                );
              }).toList(),
                
              
                onChanged: (int? newValue) {
                setState(() {
                  selectedAddressIndex = newValue!;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPaymentMethodSection() {
    List<String> paymentMethods = ['Chuyển khoản ngân hàng', 'Thanh toán khi nhận hàng'];

    // Đảm bảo rằng phương thức thanh toán hiện tại là một trong các phương thức hợp lệ.
    if (!paymentMethods.contains(selectedPaymentMethod)) {
        selectedPaymentMethod = paymentMethods.first;
    }

    return Card(
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    const Text('Phương thức thanh toán',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    DropdownButton<String>(
                        value: selectedPaymentMethod,
                        isExpanded: true,
                        items: paymentMethods.map<DropdownMenuItem<String>>((String method) {
                            return DropdownMenuItem<String>(
                                value: method,
                                child: Text(method),
                            );
                        }).toList(),
                        onChanged: (String? newValue) {
                            setState(() {
                                selectedPaymentMethod = newValue!;
                            });
                        },
                    ),
                ],
            ),
        ),
    );
}


  Widget buildTotalSection(
      double totalAmount, double discount, double finalAmount) {
    return Column(
      children: [
        buildAmountRow('Tổng thu', totalAmount),
        buildAmountRow('Mã giảm giá', discount),
        buildAmountRow('Tổng tiền', finalAmount, isTotal: true),
      ],
    );
  }

  Widget buildAmountRow(String label, double amount, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  fontSize: isTotal ? 20 : 16,
                  fontWeight: isTotal ? FontWeight.bold : FontWeight.normal)),
          Text('${NumberFormat('###,###,###').format(amount)} VND',
              style: TextStyle(
                  fontSize: isTotal ? 20 : 16,
                  fontWeight: isTotal ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token != null) {
      APIRepository apiRepository = APIRepository();
      try {
        User userData = await apiRepository.currentUser(token);
        log(
            'User data: ${userData.fullName}, ${userData.imageURL}'); // Thông báo gỡ lỗi
        setState(() {
          user = userData;
        });
      } catch (e) {
        log('Không thể tải dữ liệu người dùng: $e');
      }
    }
  }
}
