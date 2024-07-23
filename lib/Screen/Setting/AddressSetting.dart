import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddressListPage extends StatefulWidget {
  final String token;
  const AddressListPage({Key? key, required this.token}) : super(key: key);

  @override
  State<AddressListPage> createState() => _AddressListPageState();
}

class _AddressListPageState extends State<AddressListPage> {
  List<String> addresses = [];

  @override
  void initState() {
    super.initState();
    _loadAddresses();
  }

  Future<void> _loadAddresses() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      addresses = prefs.getStringList('addresses') ?? [];
    });
  }

  Future<void> _saveAddresses() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('addresses', addresses);
  }

  void _addNewAddress(String newAddress) {
    setState(() {
      addresses.add(newAddress);
      _saveAddresses();
    });
  }

  void _editAddress(int index, String updatedAddress) {
    setState(() {
      addresses[index] = updatedAddress;
      _saveAddresses();
    });
  }

  void _deleteAddress(int index) {
    setState(() {
      addresses.removeAt(index);
      _saveAddresses();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quản lý Địa Chỉ"),
      ),
      body: ListView.builder(
        itemCount: addresses.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(addresses[index]),
            onTap: () {
              Navigator.pop(context, addresses[index]);
            },
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    _showEditAddressDialog(index);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    _deleteAddress(index);
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddAddressDialog,
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddAddressDialog() {
    TextEditingController addressController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Thêm Địa Chỉ Mới'),
          content: TextField(
            controller: addressController,
            decoration: InputDecoration(hintText: 'Nhập địa chỉ mới'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Hủy'),
            ),
            TextButton(
              onPressed: () {
                if (addressController.text.isNotEmpty) {
                  _addNewAddress(addressController.text);
                  Navigator.pop(context);
                }
              },
              child: Text('Lưu'),
            ),
          ],
        );
      },
    );
  }

  void _showEditAddressDialog(int index) {
    TextEditingController addressController = TextEditingController();
    addressController.text = addresses[index];
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Chỉnh sửa Địa Chỉ'),
          content: TextField(
            controller: addressController,
            decoration: InputDecoration(hintText: 'Nhập địa chỉ mới'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Hủy'),
            ),
            TextButton(
              onPressed: () {
                if (addressController.text.isNotEmpty) {
                  _editAddress(index, addressController.text);
                  Navigator.pop(context);
                }
              },
              child: Text('Lưu'),
            ),
          ],
        );
      },
    );
  }
}
