import 'model.dart';

// create data with amount

createDataList(int amount) {
  List<ProductModel> lstProduct = [];
  for (int i = 1; i <= amount; i++) {
    lstProduct.add(ProductModel(
        id: 1,
        name: "Dien thoai new version $i",
        price: i * 1000000,
        img: "img_$i.jpg",
        des: "Iphone"));
  }
  return lstProduct;
}
