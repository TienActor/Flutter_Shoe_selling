import 'package:flutter/material.dart';
import '../Config/api_urls.dart';
import '../data/category.dart';
import 'add_brand_ad.dart';
import 'EditBrandAd.dart';

class BrandsPage extends StatefulWidget {
  final String token;
  final String accountID;

  const BrandsPage({Key? key, required this.token, required this.accountID})
      : super(key: key);

  @override
  _BrandsPageState createState() => _BrandsPageState();
}

class _BrandsPageState extends State<BrandsPage> {
  List<CategoryModel> brands = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchBrands();
  }

  Future<void> fetchBrands() async {
    APIRepository apiRepository = APIRepository();
    try {
      brands = await apiRepository.getCategory(widget.accountID, widget.token);
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error fetching categories: $e')));
    }
  }

  Future<void> refreshBrands() async {
    await fetchBrands();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('Thương hiệu'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              var result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddBrandPage(
                      token: widget.token, accountID: widget.accountID),
                ),
              );
              // Check if result is not null and true before refreshing
              if (result != null && result == true) {
                refreshBrands();
              }
            },
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: refreshBrands,
              child: ListView.builder(
                itemCount: brands.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 5,
                    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: ListTile(
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      leading: Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                            image: NetworkImage(brands[index].imageURL ?? ''),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      title: Text(brands[index].name ?? 'Chưa có tên'),
                      subtitle:
                          Text(brands[index].description ?? 'Chưa có mô tả'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () async {
                              var result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditBrandPage(
                                      brand: brands[index],
                                      token: widget.token,
                                      accountID: widget.accountID),
                                ),
                              );
                              // Check if result is not null and true before refreshing
                              if (result != null && result == true) {
                                refreshBrands();
                              }
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _confirmDelete(brands[index].id!),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }

  void _confirmDelete(int id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Xác nhận xóa"),
          content: const Text("Bạn có chắc muốn xóa thương hiệu này ?"),
          actions: <Widget>[
            TextButton(
              child: const Text('Hủy'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Xóa'),
              onPressed: () async {
                await _deleteCategory(id);
                Navigator.of(context).pop(); // Close the dialog after deletion
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteCategory(int id) async {
    APIRepository apiRepository = APIRepository();
    bool success =
        await apiRepository.removeCategory(id, widget.accountID, widget.token);
    if (success) {
      refreshBrands(); // Refresh the list after successful deletion
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Xóa thành công')));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Xoá thất bại')));
    }
  }
}
