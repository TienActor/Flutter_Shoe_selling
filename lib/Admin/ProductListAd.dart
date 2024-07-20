import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Config/api_urls.dart';
import '../data/product.dart';
import 'EditProduct.dart';
import 'ProductdetailAd.dart';

class ProductListScreen extends StatefulWidget {
  final String token;
  final String accountID;

  const ProductListScreen({Key? key, required this.token, required this.accountID})
      : super(key: key);

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  late Future<List<ProductModel>> products;

  @override
  void initState() {
    super.initState();
    products = APIRepository().fetchProducts(widget.accountID, widget.token);
  }

  void _reloadProductList() {
    setState(() {
      products = APIRepository().fetchProducts(widget.accountID, widget.token);
    });
  }

  Widget _buildProductItem(BuildContext context, ProductModel product) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text(product.name, style: GoogleFonts.abel(fontSize: 18,fontWeight: FontWeight.bold)),
        subtitle: Text(product.categoryName),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: CachedNetworkImage(
            imageUrl: product.imageURL,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        ),
        trailing: _buildTrailingButtons(product),
        onTap: () => _navigateToProductDetails(context, product),
      ),
    );
  }

  Widget _buildTrailingButtons(ProductModel product) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(Icons.edit, color: Colors.blue),
          onPressed: () => _editProduct(product),
          tooltip: 'Edit',
        ),
        IconButton(
          icon: Icon(Icons.delete, color: Colors.red),
          onPressed: () => _confirmDelete(product),
          tooltip: 'Delete',
        ),
      ],
    );
  }

  void _editProduct(ProductModel product) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProductScreen(product: product, token: widget.token, accountID: widget.accountID),
      ),
    );
    if (result == true) {
      _reloadProductList();
    }
  }

  void _confirmDelete(ProductModel product) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Xác nhận xóa"),
          content: Text("Bạn có chắc muốn xóa ${product.name}?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Hủy"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                print('Delete button pressed for ${product.name}');
                // Here add your deletion logic
              },
              child: Text("Xoá"),
            ),
          ],
        );
      },
    );
  }

  void _navigateToProductDetails(BuildContext context, ProductModel product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailScreen(product: product),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Danh sách sản phẩm"),
      ),
      body: FutureBuilder<List<ProductModel>>(
        future: products,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) => _buildProductItem(context, snapshot.data![index]),
            );
          } else {
            return Center(child: Text("No products found"));
          }
        },
      ),
    );
  }
}
