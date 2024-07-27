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
