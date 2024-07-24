import 'package:flutter/material.dart';
import '../Config/api_urls.dart';
import '../data/category.dart';

class AddBrandPage extends StatefulWidget {
  final String token;
  final String accountID;

  const AddBrandPage({Key? key, required this.token, required this.accountID})
      : super(key: key);

  @override
  _AddBrandPageState createState() => _AddBrandPageState();
}

class _AddBrandPageState extends State<AddBrandPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _imageURLController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _descriptionController = TextEditingController();
    _imageURLController = TextEditingController();
  }

  Future<void> _addBrand() async {
    if (_formKey.currentState!.validate()) {
      CategoryModel newCategory = CategoryModel(
        name: _nameController.text,
        description: _descriptionController.text,
        imageURL: _imageURLController.text,
      );

      APIRepository apiRepository = APIRepository();
      bool success = await apiRepository.addCategory(
          newCategory, widget.accountID, widget.token);
      if (success) {
        Navigator.pop(
            context, true); // Return true to indicate addition was successful
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Thêm thành công')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Thêm thất bại')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Thêm thương hiệu'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              // Brand Name Field
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Tên thương hiệu',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.business),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập tên thương hiệu';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Description Field
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Mô tả',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.description),
                ),
                 validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập mô tả';
                  }
                  return null;
                },
                maxLines: 3,
              ),
              SizedBox(height: 16),

              // Image URL Field
              TextFormField(
                controller: _imageURLController,
                decoration: InputDecoration(
                  labelText: 'Hình ảnh',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.image),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập hình ảnh';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              // Add Brand Button
              ElevatedButton(
                onPressed: _addBrand,
                child: Text('Thêm Thương Hiệu'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, // Text color
                  backgroundColor: Colors.blue, // Button color
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
