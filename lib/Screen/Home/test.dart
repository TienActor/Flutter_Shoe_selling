import 'package:flutter/material.dart';

class ShoeStoreHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.black),
          onPressed: () {},
        ),
        title: Image.asset(
          'assets/images/Logo.png',
          height: 40,
          width: 40,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.shopping_bag_outlined, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Sản phẩm theo hãng',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 16),
              Container(
                width: 400,
                height: 80,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Container(
                    width: 90,
                    height: 80,
                     decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(40)),
            color: Color.fromRGBO(236, 233, 233, 1),
          ),
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                  child: Center(
                    child: Container(
                      width: 40,
                      height: 27,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/Image52.png'),
                          fit: BoxFit.fitWidth
                        ),
                      ),
                    ),
                  ),
                  ),
                ),
              ),
              Text('Giày phổ biến',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Nike Jordan'),
                  Text('Tất cả', style: TextStyle(color: Colors.blue)),
                ],
              ),
              SizedBox(height: 8),
              GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 2 / 3,
                ),
                itemCount: 6, // Number of items
                itemBuilder: (context, index) {
                  return ShoeCard();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ShoeCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset('assets/images/shoe.png',
                    height: 100), // Replace with actual image
                Positioned(
                  top: 8,
                  right: 8,
                  child: Icon(Icons.favorite_border, color: Colors.grey),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text('BÁN CHẠY',
                style: TextStyle(fontSize: 12, color: Colors.blue)),
            SizedBox(height: 4),
            Text('Nike Air Max',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text('3,000,000 VND',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Icon(Icons.add, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
