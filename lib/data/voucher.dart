class Discount {
  String title;
  String minOrder;
  String discount;
  DateTime validity; // Thay đổi kiểu dữ liệu
  int quantity;

  Discount({required this.title, required this.minOrder, required this.discount, required this.validity, required this.quantity});

  factory Discount.fromJson(Map<String, dynamic> json) {
    return Discount(
      title: json['title'],
      minOrder: json['minOrder'],
      discount: json['discount'],
      validity: DateTime.parse(json['validity']),
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'minOrder': minOrder,
      'discount': discount,
      'validity': validity.toIso8601String(),
      'quantity': quantity,
    };
  }
}
