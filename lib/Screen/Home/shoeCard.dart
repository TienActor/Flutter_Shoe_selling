// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:tien/data/product.dart';
// import 'package:tien/Screen/Cart/cartProvider.dart';

// class ShoeCard extends StatelessWidget {
//   final ProductModel product;
//   ShoeCard({required this.product});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//       elevation: 4,
//       child: InkWell(
//         onTap: () {}, // Placeholder for onTap action
//         child: Column(
//           children: [
//             Expanded(
//               child: Stack(
//                 children: [
//                   ClipRRect(
//                     borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//                     child: Image.network(product.imageURL, fit: BoxFit.cover),
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(product.name, style: TextStyle(fontWeight: FontWeight.bold)),
//                   Text('${NumberFormat('###,###,###').format(product.price)} VND', style: TextStyle(color: Colors.red)),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       Align(
//                         alignment: Alignment.bottomRight,
//                         child: Padding(
//                           padding: EdgeInsets.only(right: 8, bottom: 8),
//                           child: CircleAvatar(
//                             radius: 20,
//                             backgroundColor: Colors.blue,
//                             child: IconButton(
//                               icon: Icon(Icons.add, color: Colors.white),
//                               onPressed: () {
//                                 Provider.of<CartProvider>(context, listen: false).addProduct(product);
//                                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                                   content: Text('Đã thêm vào giỏ hàng'),
//                                   duration: Duration(seconds: 2),
//                                 ));
//                               },
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
