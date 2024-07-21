import 'package:flutter/material.dart';
import '../Config/api_urls.dart';
import '../data/product.dart';
import 'AddProductAd.dart'; // Đảm bảo rằng đã import màn hình thêm sản phẩm
import 'EditProduct.dart';
import 'ProductDetailAd.dart';

class ProductListScreen extends StatefulWidget {
  final String token;
  final String accountID;

  const ProductListScreen({Key? key, required this.token, required this.accountID}) : super(key: key);

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

  Future<void> _refreshProductList() async {
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
        title: Text(product.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        subtitle: Text(product.categoryName),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.network(product.imageURL, width: 50, height: 50, fit: BoxFit.cover),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit, color: Colors.blue),
              onPressed: () => _navigateToEditProduct(context, product),
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () => _confirmDelete(context, product),
            ),
          ],
        ),
        onTap: () => _navigateToProductDetails(context, product),
      ),
    );
    
  }
void _navigateToProductDetails(BuildContext context, ProductModel product) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ProductDetailScreen(product: product, token: widget.token, accountID: widget.accountID),
    ),
  ).then((value) {
    if (value == true) { // If 'true' is received, refresh the list
      _refreshProductList(); // Assuming this method refreshes the data
    }
  });
}


  void _navigateToEditProduct(BuildContext context, ProductModel product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProductScreen(product: product, token: widget.token, accountID: widget.accountID),
      ),
    ).then((_) => _refreshProductList()); 
  }

void _confirmDelete(BuildContext context, ProductModel product) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Xác nhận xóa"),
        content: Text("Bạn có chắc muốn xóa sản phẩm ${product.name}?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("Hủy"),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop(); // Close the dialog first
              await _deleteProduct(product.id, widget.accountID, widget.token);
            },
            child: Text("Xóa"),
          ),
        ],
      );
    },
  );
}

Future<void> _deleteProduct(int productId, String accountId, String token) async {
  bool success = await APIRepository().removeProduct(productId, accountId, token);
  if (success) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sản phẩm đã được xóa thành công')));
    _refreshProductList(); // Refresh the product list to reflect the deletion
  } else {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Không thể xóa sản phẩm')));
  }
}




  void _openAddProductScreen() async {
    bool? result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddProductScreen(token: widget.token, accountID: widget.accountID),
      ),
    );

    if (result == true) {
      _refreshProductList(); // Refresh the list upon successful product addition
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Danh sách sản phẩm"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _openAddProductScreen,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshProductList,
        child: FutureBuilder<List<ProductModel>>(
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
      ),
    );
  }
}
