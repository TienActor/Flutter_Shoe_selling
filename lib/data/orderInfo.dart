class OrderInfo {
  final int productId;
  final int count;
  final String email;
  final String phone;
  final String address;
  final String paymentMethod;

  OrderInfo({
    required this.productId,
    required this.count,
    required this.email,
    required this.phone,
    required this.address,
    required this.paymentMethod,
  });

   factory OrderInfo.fromJson(Map<String, dynamic> json) {
    return OrderInfo(
      productId: json['productId'],
      count: json['count'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      paymentMethod: json['paymentMethod'],
    );
  }

  Map<String, dynamic> toJson() => {
        'productId': productId,
        'count': count,
        'email': email,
        'phone': phone,
        'address': address,
        'paymentMethod': paymentMethod,
      };
}
