import 'package:flutter/material.dart';
import '../data/product.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductModel product;

  const ProductDetailScreen({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        actions: [
          IconButton(
            icon: Icon(Icons.edit), 
            onPressed: () {
              // TODO: Implement edit functionality
              print('Edit button pressed');
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              // TODO: Implement delete functionality
              print('Delete button pressed');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: 'productImage${product.id}',
              child: CachedNetworkImage(
                imageUrl: product.imageURL,
                fit: BoxFit.cover,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
                height: 300,
                width: double.infinity,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.name, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  Text("Giá: \$${product.price}", style: TextStyle(fontSize: 20, color: Colors.red)),
                  SizedBox(height: 10),
                  Text("Thể loại: ${product.categoryName}", style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic)),
                  SizedBox(height: 10),
                  Text(product.description, textAlign: TextAlign.justify, style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
