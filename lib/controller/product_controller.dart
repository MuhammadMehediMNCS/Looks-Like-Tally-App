import 'package:book_balance/model/products.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  var productList = <Products>[].obs;

  void addProduct(Products product) {
    productList.add(product);
  }

   void deleteProduct(int index) {
    productList.removeAt(index);
  }
}
