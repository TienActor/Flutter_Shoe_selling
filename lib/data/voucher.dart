class Discount {
  String code;
  String title;
  String minOrder;
  String discount;
  DateTime validity;
  DateTime creationTime;
  int quantity;

  Discount(
      {required this.code,
      required this.title,
      required this.minOrder,
      required this.discount,
      required this.validity,
      required this.creationTime,
      required this.quantity});

  factory Discount.fromJson(Map<String, dynamic> json) {
    return Discount(
      code: json['code'],
      title: json['title'],
      minOrder: json['minOrder'],
      discount: json['discount'],
      validity: DateTime.parse(json['validity']),
      creationTime: DateTime.parse(json['creationTime']),
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'title': title,
      'minOrder': minOrder,
      'discount': discount,
      'validity': validity.toIso8601String(),
      'creationTime': creationTime.toIso8601String(),
      'quantity': quantity,
    };
  }
}
