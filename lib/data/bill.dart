class BillModel {
  final String id;
  final String fullName;
  final String dateCreated;
  final int total;

  BillModel({
    required this.id,
    required this.fullName,
    required this.dateCreated,
    required this.total,
  });

  factory BillModel.fromJson(Map<String, dynamic> json) {
    return BillModel(
      id: json['id'],
      fullName: json['fullName'],
      dateCreated: json['dateCreated'],
      total: json['total'],
    );
  }
}
class BillDetailModel {
  final int productID;
  final String productName;
  final String imageURL;
  final double price;
  final int count;
  final double total;

  BillDetailModel({
    required this.productID,
    required this.productName,
    required this.imageURL,
    required this.price,
    required this.count,
    required this.total,
  });

  factory BillDetailModel.fromJson(Map<String, dynamic> json) {
    return BillDetailModel(
      productID: json['productID'],
      productName: json['productName'],
      imageURL: json['imageURL'],
      price: json['price'].toDouble(),
      count: json['count'],
      total: json['total'].toDouble(),
    );
  }
}