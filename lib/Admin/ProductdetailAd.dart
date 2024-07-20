import 'package:flutter/material.dart';
import '../data/product.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductModel product;

  const ProductDetailScreen({Key? key, required this.product}) : super(key: key);

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text(product.name),
    ),
    body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(product.imageURL, fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.name, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                Text("Price: \$${product.price}", style: TextStyle(fontSize: 20, color: Colors.red)),
                SizedBox(height: 10),
                Text("Category: ${product.categoryName}", style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic)),
                SizedBox(height: 10),
                Text(product.description, style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ],
      ),
    ),
    floatingActionButton: Stack(
      children: [
        Positioned(
          bottom: 50,
          right: 10,
          child: FloatingActionButton(
            onPressed: () {
              // TODO: Implement edit functionality
              print('Edit button pressed');
            },
            child: Icon(Icons.edit),
            backgroundColor: Colors.blue,
          ),
        ),
        Positioned(
          bottom: 110,
          right: 10,
          child: FloatingActionButton(
            onPressed: () {
              // TODO: Implement delete functionality
              print('Delete button pressed');
            },
            child: Icon(Icons.delete),
            backgroundColor: Colors.red,
          ),
        ),
      ],
    ),
  );
}

}
