import 'package:book_balance/controller/product_controller.dart';
import 'package:book_balance/model/products.dart';
import 'package:book_balance/widget/button_widget.dart';
import 'package:book_balance/widget/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class ProductDataScreen extends StatefulWidget {
  final Products? product;
  final int? index;

  const ProductDataScreen({super.key, this.product, this.index});

  @override
  State<ProductDataScreen> createState() => _ProductDataScreenState();
}

class _ProductDataScreenState extends State<ProductDataScreen> {
  TextEditingController productController = TextEditingController();
  TextEditingController totalProductController = TextEditingController();
  TextEditingController buyDatetController = TextEditingController();
  TextEditingController buyTimeController = TextEditingController();
  TextEditingController buyAmountController = TextEditingController();
  TextEditingController saleAmountController = TextEditingController();
  TextEditingController useTimeController = TextEditingController();
  TextEditingController mfgController = TextEditingController();
  TextEditingController expController = TextEditingController();

  final ProductController controller = Get.find<ProductController>();

  Timer? _timer;

  @override
  void initState() {
    super.initState();

    if (widget.product != null) {
      productController.text = widget.product!.name;
      totalProductController.text = widget.product!.totalProduct.toString();
      buyDatetController.text = widget.product!.buyDate;
      buyTimeController.text = widget.product!.buyTime;
      buyAmountController.text = widget.product!.buyAmount.toString();
      saleAmountController.text = widget.product!.saleAmount.toString();
      useTimeController.text = widget.product!.useTime.toString();
      mfgController.text = widget.product!.mfgDate;
      expController.text = widget.product!.expDate;
    } else {
      final DateTime now = DateTime.now();
      final formattedDate = DateFormat('dd MMM yyyy').format(now);
      final formattedTime = DateFormat('hh:mm a').format(now);

      buyDatetController.text = formattedDate;
      buyTimeController.text = formattedTime;

      _updateTimeOfUse();
    }

    _timer = Timer.periodic(const Duration(days: 1), (timer) {
      _updateTimeOfUse();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        controller.text = DateFormat('dd MMM yyyy').format(picked);
        _updateTimeOfUse();
      });
    }
  }

  void _updateTimeOfUse() {
    if (expController.text.isNotEmpty) {
      final DateTime now = DateTime.now();
      final DateTime expDate = DateFormat('dd MMM yyyy').parse(expController.text);
      final int differenceInDays = expDate.difference(now).inDays;
      
      setState(() {
        useTimeController.text = differenceInDays.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product == null ? 'New Product' : 'Edit Product'),
        actions: [
          IconButton(
            onPressed: () {
              productController.clear();
              totalProductController.clear();
              buyAmountController.clear();
              saleAmountController.clear();
              useTimeController.clear();
              mfgController.clear();
              expController.clear();
            },
            icon: const Column(
              children: [
                Icon(Icons.cleaning_services_rounded, size: 18,),
                Text('Clear Field', style: TextStyle(fontSize: 8))
              ],
            )
          ),
          const SizedBox(width: 12.0)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: TextFieldWidget(
                          title: 'Product Name :',
                          controller: productController
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.2,
                        child: TextFieldWidget(
                          title: 'Total Product :',
                          controller: totalProductController,
                          keyboard: TextInputType.number,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 24.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: TextFieldWidget(
                          title: 'Buy Date :',
                          controller: buyDatetController
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: TextFieldWidget(
                          title: 'Time :',
                          controller: buyTimeController,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 24.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: TextFieldWidget(
                          title: 'Buy Amount :',
                          controller: buyAmountController,
                          keyboard: TextInputType.number
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: TextFieldWidget(
                          title: 'Sale Amount :',
                          controller: saleAmountController,
                          keyboard: TextInputType.number
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: TextFieldWidget(
                          title: 'Time of Use :',
                          controller: useTimeController,
                          keyboard: TextInputType.number,
                          readOnly: true,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 24.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: TextFieldWidget(
                          title: 'Manufacture Date :',
                          controller: mfgController,
                          onPressed: () => _selectDate(context, mfgController),
                          readOnly: true,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: TextFieldWidget(
                          title: 'Expire Date :',
                          controller: expController,
                          onPressed: () => _selectDate(context, expController),
                          readOnly: true,
                        ),
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox( height: 32),
              ButtonWidget(
                title: widget.product == null ? 'Confirm' : 'Update',
                onPressed: () {
                  final Products updatedProduct = Products(
                    name: productController.text,
                    totalProduct: totalProductController.text.isNotEmpty ? int.parse(totalProductController.text) : 0,
                    buyDate: buyDatetController.text,
                    buyTime: buyTimeController.text,
                    buyAmount: buyAmountController.text.isNotEmpty ? double.parse(buyAmountController.text) : 0.0,
                    saleAmount: saleAmountController.text.isNotEmpty ? double.parse(saleAmountController.text) : 0.0,
                    mfgDate: mfgController.text,
                    expDate: expController.text,
                    useTime: useTimeController.text.isNotEmpty ? int.parse(useTimeController.text) : 0,
                  );

                  if (widget.index != null) {
                    controller.productList[widget.index!] = updatedProduct;
                  } else {
                    controller.addProduct(updatedProduct);
                  }

                  Get.back();
                }
              )
            ],
          ),
        ),
      ),
    );
  }
}