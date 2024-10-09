import 'package:book_balance/controller/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductTransactionPage extends StatefulWidget {
  const ProductTransactionPage({super.key});

  @override
  State<ProductTransactionPage> createState() => _ProductTransactionPageState();
}

class _ProductTransactionPageState extends State<ProductTransactionPage> {
  final ProductController controller = Get.find();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Information of ")
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Text('data')
            ],
          ),
        ),
      )
    );
  }
}