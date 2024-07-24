import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tien/Config/api_urls.dart';
import 'package:tien/data/product.dart';
import 'package:tien/Screen/Home/detail.dart';
import 'package:tien/Screen/Cart/cartProvider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AllProductsPage extends StatefulWidget {
  final String token;
  final String accountID;

  AllProductsPage({required this.token, required this.accountID});

  @override
  _AllProductsPageState createState() => _AllProductsPageState();
}

class _AllProductsPageState extends State<AllProductsPage> {
  List<ProductModel> products = [];

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  void fetchProducts() async {
    List<ProductModel> fetchedProducts = await APIRepository().fetchProducts(widget.accountID, widget.token);
    setState(() {
      products = fetchedProducts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tất cả sản phẩm"),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.75,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          var product = products[index];
          return ShoeCard(
            product: product,
            token: widget.token,
            relatedProducts: products, // assuming all products can be related, adjust if needed
          );
        },
      ),
    );
  }
}
class ShoeCard extends StatefulWidget {
  final ProductModel product;
  final String token;
  final List<ProductModel> relatedProducts;
  ShoeCard({required this.product,required this.token, required this.relatedProducts});
  @override
  _ShoeCardState createState() => _ShoeCardState();
}

class _ShoeCardState extends State<ShoeCard> {

  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _loadFavoriteStatus();
  }

  Future<void> _loadFavoriteStatus() async {
    final prefs = await SharedPreferences.getInstance();
    var favoriteStatus = prefs.get(widget.product.id.toString());
    if (favoriteStatus is bool) {
      setState(() {
        isFavorite = favoriteStatus;
      });
    } else {
      setState(() {
        isFavorite = false;
      });
    }
  }

  Future<void> _toggleFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    bool newFavoriteStatus = !isFavorite;
    await prefs.setBool(widget.product.id.toString(), newFavoriteStatus);
    setState(() {
      isFavorite = newFavoriteStatus;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:
            Text(isFavorite ? "Đã yêu thích" : "Đã xóa yêu thích"),
        duration: const Duration(seconds: 2),
      ),
    );
  }

   @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 4,
      child: InkWell(
        onTap: () {
 Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailPage(
                productId: widget.product.id,
                productName: widget.product.name,
                productImage: widget.product.imageURL,
                productPrice: widget.product.price,
                productDescription: widget.product.description,
                relatedProducts: widget.relatedProducts,
                token: widget.token,
              ),
            ),
          );

        },
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                    child: Image.network(widget.product.imageURL, fit: BoxFit.cover),
                  ),
                  Positioned(
                    top: 8,
                    right: 128,
                    child: GestureDetector(
                      onTap:_toggleFavorite
                      //  () {
                      //   setState(() {
                      //     isFavorite = !isFavorite;
                      //   });
                      // }
                      ,
                      child: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : Colors.grey,
                        size: 24,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.product.name, style: const TextStyle(fontWeight: FontWeight.bold),maxLines: 1,),
                  Text('${NumberFormat('###,###,###').format(widget.product.price)} VND', style: const TextStyle(color: Colors.red)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8, bottom: 8),
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.blue,
                            child: IconButton(
                              icon: const Icon(Icons.add, color: Colors.white),
                              onPressed: () {
                                Provider.of<CartProvider>(context, listen: false).addProduct(widget.product);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Đã thêm vào giỏ hàng thành công"),
                                    duration: const Duration(seconds: 2),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}