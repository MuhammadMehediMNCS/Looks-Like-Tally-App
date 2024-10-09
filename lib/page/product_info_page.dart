import 'package:book_balance/controller/product_controller.dart';
import 'package:book_balance/page/product_transaction_page.dart';
import 'package:book_balance/screen/product_data_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductInfoPage extends StatefulWidget {
  const ProductInfoPage({super.key});

  @override
  State<ProductInfoPage> createState() => _ProductInfoPageState();
}

class _ProductInfoPageState extends State<ProductInfoPage> {
  final ProductController controller = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Obx( () {
          final sortedProducts = List.from(controller.productList);
          sortedProducts.sort((a, b) => a.name.compareTo(b.name));

           return sortedProducts.isEmpty ? const Center(
            child: Text(
              "Don't have any Products",
              style: TextStyle(color: Colors.grey, fontSize: 18.0),
            ),
           ) : ListView.builder(
            itemCount: controller.productList.length,
            itemBuilder: (context, index) {
              final product = sortedProducts[index];
              final bool isExpired = product.useTime == 0;

              return Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: GestureDetector(
                  onTap: () {
                     _showBottomSheet(context, index);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.black12)
                    ),
                    height: 100.0,
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12.0),
                          height: 60.0,
                          width: 60.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all()
                          ),
                          child: Center(
                            child: Text(
                              product.buyDate,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    product.name,
                                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                                  ),
                                  Text(
                                    product.totalProduct.toString(),
                                    style: const TextStyle(color: Colors.blue, fontSize: 18, fontWeight: FontWeight.bold)
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "S.${product.saleAmount}",
                                    style: const TextStyle(color: Colors.green, fontSize: 12)
                                  ),
                                  Text(
                                    "B.${product.buyAmount}",
                                    style: const TextStyle(color:  Colors.red, fontSize: 12)
                                  )
                                ],
                              ),
                              if (product.expDate.isNotEmpty)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Mfg Date : ${product.mfgDate}",
                                    style: const TextStyle(fontSize: 10)
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        product.useTime.toString(),
                                        style: TextStyle(
                                          color: isExpired ? Colors.red : Colors.green,
                                          fontWeight: isExpired ? FontWeight.bold : FontWeight.normal,
                                        ),
                                      ),
                                      if (isExpired) ...[
                                        const SizedBox(width: 4.0),
                                        const Icon(Icons.thumb_down, color: Colors.red, size: 16),
                                      ]
                                    ],
                                  ),
                                  Text(
                                    "Exp Date : ${product.expDate}",
                                    style: const TextStyle(fontSize: 10)
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        shape: const CircleBorder(),
        onPressed: () {
          Get.to(const ProductDataScreen());
        },
        child: const Icon(
          Icons.person_add,
          color: Colors.white,
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context, int index) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.restore_page),
                title: const Text('Report', style: TextStyle(fontWeight: FontWeight.bold)),
                onTap: () {
                  Get.off(const ProductTransactionPage());
                },
              ),
              ListTile(
                leading: const Icon(Icons.edit_note),
                title: const Text('Edit', style: TextStyle(fontWeight: FontWeight.bold)),
                onTap: () {
                  Get.back();
                    Get.to(ProductDataScreen(
                    product: controller.productList[index],
                    index: index,
                  ));
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: const Text('Delete', style: TextStyle(fontWeight: FontWeight.bold)),
                onTap: () {
                  controller.deleteProduct(index);
                  Get.back();
                },
              ),
              ListTile(
                leading: const Icon(Icons.cancel),
                title: const Text('Cancel', style: TextStyle(fontWeight: FontWeight.bold)),
                onTap: () {
                  Get.back();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
