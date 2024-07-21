import '../Config/api_urls.dart';
import '../data/category.dart';
import 'package:flutter/material.dart';

class EditBrandPage extends StatefulWidget {
  final String token;
  final String accountID;
  final CategoryModel brand;

  const EditBrandPage({Key? key, required this.token, required this.accountID, required this.brand}) : super(key: key);

  @override
  _EditBrandPageState createState() => _EditBrandPageState();
}

class _EditBrandPageState extends State<EditBrandPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _imageURLController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.brand.name);
    _descriptionController = TextEditingController(text: widget.brand.description);
    _imageURLController = TextEditingController(text: widget.brand.imageURL);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sửa thương hiệu'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: <Widget>[
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Tên thương hiệu'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Vui lòng nhập tên thương hiệu';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Mô tả'),
            ),
            TextFormField(
              controller: _imageURLController,
              decoration: InputDecoration(labelText: 'Hình ảnh'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateBrand,
              child: Text('Cập Nhật Thương Hiệu'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.blue, // Text color
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _updateBrand() async {
    if (_formKey.currentState!.validate()) {
      CategoryModel updatedCategory = CategoryModel(
        id: widget.brand.id,
        name: _nameController.text,
        description: _descriptionController.text,
        imageURL: _imageURLController.text,
      );

      APIRepository apiRepository = APIRepository();
      bool success = await apiRepository.updateCategory(updatedCategory.id!, updatedCategory, widget.accountID, widget.token);
      if (success) {
        Navigator.pop(context, true);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Cập nhật thành công'))
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Cập nhật thất bại'))
        );
      }
    }
  }
}
