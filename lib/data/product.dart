class ProductModel {
  final int id;
  final String name;
  final String description;
  final String imageURL;
  final double price;
  final int categoryID;
  final String categoryName;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imageURL,
    required this.price,
    required this.categoryID,
    required this.categoryName,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageURL: json['imageURL'],
      price: json['price'].toDouble(),
      categoryID: json['categoryID'],
      categoryName: json['categoryName'],
    );
  }
}