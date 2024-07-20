import 'package:flutter/material.dart';

import '../Config/api_urls.dart';
import '../data/product.dart'; // Đảm bảo đường dẫn chính xác

class EditProductScreen extends StatefulWidget {
  final ProductModel product;
  final String token;
  final String accountID;

  const EditProductScreen({Key? key, required this.product, required this.token, required this.accountID}) : super(key: key);

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;
  late TextEditingController _imageURLController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.product.name);
    _descriptionController = TextEditingController(text: widget.product.description);
    _priceController = TextEditingController(text: widget.product.price.toString());
    _imageURLController = TextEditingController(text: widget.product.imageURL);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Product"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: _priceController,
              decoration: InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            TextField(
              controller: _imageURLController,
              decoration: InputDecoration(labelText: 'Image URL'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateProduct,
              child: Text('Update Product'),
            )
          ],
        ),
      ),
    );
  }

Future<void> _updateProduct() async {
  final updatedProduct = ProductModel(
    id: widget.product.id,
    name: _nameController.text,
    description: _descriptionController.text,
    imageURL: _imageURLController.text,
    price: double.tryParse(_priceController.text) ?? widget.product.price,
    categoryID: widget.product.categoryID,
    categoryName: widget.product.categoryName,
  );
  
  APIRepository apiRepository = APIRepository();
  bool success = await apiRepository.updateProduct(updatedProduct, widget.accountID, widget.token);
 if (success) {
  Navigator.pop(context, true); // Trả về 'true' để chỉ ra rằng cập nhật thành công
} else {
  Navigator.pop(context, false); // Trả về 'false' nếu cập nhật thất bại
}

}

}
