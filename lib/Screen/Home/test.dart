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
          icon: const Icon(Icons.menu, color: Colors.black),
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
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.shopping_bag_outlined, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Sản phẩm theo hãng',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(width: 16),
              Row(
                children: [
                  Container(
                    width: 60,
                    height: 40,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                              // Bỏ thuộc tính color hoặc đặt nó dưới image để hình ảnh không bị che phủ
                              image: DecorationImage(
                    image: NetworkImage('https://i.pinimg.com/736x/d4/20/46/d4204662d48e847dbf4dff048863546c.jpg'),
                    fit: BoxFit.fill)
                    ),
                  ),
                   const SizedBox(width: 48),
                  Container(
                    width: 60,
                    height: 40,
                    
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                              // Bỏ thuộc tính color hoặc đặt nó dưới image để hình ảnh không bị che phủ
                              image: DecorationImage(
                    image: NetworkImage('https://w1.pngwing.com/pngs/1009/652/png-transparent-puma-logo-tshirt-sneakers-clothing-accessories-coat-black-black-and-white-silhouette.png'),
                    fit: BoxFit.fill)
                    ),
                  ),
                    const SizedBox(width: 48),
                  Container(
                    width: 60,
                    height: 40,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                              // Bỏ thuộc tính color hoặc đặt nó dưới image để hình ảnh không bị che phủ
                              image: DecorationImage(
                    image: NetworkImage('https://i.pinimg.com/originals/8c/b0/8a/8cb08a963150553f12dc40795e5cb4a3.jpg'),
                    fit: BoxFit.fill)
                    ),
                  ),
                   const SizedBox(width: 32),
                  Container(
                    width: 60,
                    height: 40,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                              // Bỏ thuộc tính color hoặc đặt nó dưới image để hình ảnh không bị che phủ
                              image: DecorationImage(
                    image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRNK1AiMRLKgSuS0kxX4UIrblJR3-ewdmI64A&s'),
                    fit: BoxFit.fill)
                    ),
                  ),
                ],
              ),
              const Text('Giày phổ biến',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Nike Jordan'),
                  Text('Tất cả', style: TextStyle(color: Colors.blue)),
                ],
              ),
              const SizedBox(height: 8),
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                Image.asset('assets/images/Hnhsnphm.png',
                    height: 100), // Replace with actual image
                const Positioned(
                  top: 8,
                  right: 8,
                  child: Icon(Icons.favorite_border, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text('BÁN CHẠY',
                style: TextStyle(fontSize: 12, color: Colors.blue)),
            const SizedBox(height: 4),
            const Text('Nike Air Max',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            const Text('3,000,000 VND',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            const Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(4.0),
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
