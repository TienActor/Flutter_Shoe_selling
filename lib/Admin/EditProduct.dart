import 'package:flutter/material.dart';
import '../Config/api_urls.dart';
import '../data/product.dart'; // Đảm bảo đường dẫn chính xác

class EditProductScreen extends StatefulWidget {
  final ProductModel product;
  final String token;
  final String accountID;

  const EditProductScreen(
      {Key? key,
      required this.product,
      required this.token,
      required this.accountID})
      : super(key: key);

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;
  late TextEditingController _imageURLController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.product.name);
    _descriptionController =
        TextEditingController(text: widget.product.description);
    _priceController =
        TextEditingController(text: widget.product.price.toString());
    _imageURLController = TextEditingController(text: widget.product.imageURL);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sửa sản phẩm"),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Tên sản phẩm',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.text_fields),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Mô tả sản phẩm',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.description),
                ),
                maxLines: 3,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(
                  labelText: 'Giá sản phẩm',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.attach_money),
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _imageURLController,
                decoration: InputDecoration(
                  labelText: 'Hình ảnh sản phẩm',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.image),
                ),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: _updateProduct,
                child: Text('Cập nhật sản phẩm'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue, // Foreground color (text color)
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _updateProduct() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
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
      bool success = await apiRepository.updateProduct(
          updatedProduct, widget.accountID, widget.token);
      if (success) {
        Navigator.pop(
            context, true); // Trả về 'true' để chỉ ra rằng cập nhật thành công
      } else {
        Navigator.pop(context, false); // Trả về 'false' nếu cập nhật thất bại
      }
    }
  }
}
