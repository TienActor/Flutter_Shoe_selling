class Cart {
  int productID;
  int count;

  Cart({
    required this.productID,
    required this.count,
  });

  // Method to convert a Cart object into a map, which is useful for JSON serialization when making API calls.
  Map<String, dynamic> toJson() {
    return {
      'productID': productID,
      'count': count,
    };
  }

  
}
