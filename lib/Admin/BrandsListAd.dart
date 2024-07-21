import 'package:flutter/material.dart';
import '../Config/api_urls.dart';
import '../data/category.dart';

class BrandsPage extends StatefulWidget {
  final String token;
  final String accountID;

  const BrandsPage({Key? key, required this.token, required this.accountID}) : super(key: key);

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
        SnackBar(content: Text('Error fetching categories: $e'))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Brands'),
        backgroundColor: Colors.deepPurple,
      ),
      body: isLoading
        ? Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple),
            )
          )
        : ListView.builder(
            itemCount: brands.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
                  title: Text(brands[index].name ?? 'No Name'),
                  subtitle: Text(brands[index].description ?? 'No Description'),
                ),
              );
            },
          ),
    );
  }
}
