import 'package:book_balance/controller/customer_controller.dart';
import 'package:book_balance/page/customer_transaction_page.dart';
import 'package:book_balance/widget/button_widget.dart';
import 'package:book_balance/widget/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CustomerDetailScreen extends StatefulWidget {
  final String title;
  final String subtitle;
  final String contact;
  final String amount;
  final int index;

  const CustomerDetailScreen({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.contact,
    required this.amount,
    required this.index,
  }) : super(key: key);

  @override
  State<CustomerDetailScreen> createState() => _CustomerDetailScreenState();
}

class _CustomerDetailScreenState extends State<CustomerDetailScreen> {
  TextEditingController receiveController = TextEditingController();
  TextEditingController sendController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  late double totalDue;
  final CustomerController controller = Get.find<CustomerController>();

  @override
  void initState() {
    super.initState();

    final DateTime now = DateTime.now();
    final String formattedDate = DateFormat('dd MMM yyyy').format(now);
    final String formattedTime = DateFormat('hh:mm a').format(now);

    dateController.text = formattedDate;
    timeController.text = formattedTime;

    totalDue = double.tryParse(widget.amount) ?? 0.0;
  }

  void updateTotalDue() {
    double sendAmount = double.tryParse(sendController.text) ?? 0.0;
    double receiveAmount = double.tryParse(receiveController.text) ?? 0.0;

    setState(() {
      totalDue = totalDue + sendAmount - receiveAmount;
    });

    controller.updateCustomer(widget.index, {
      'name': widget.title,
      'area': widget.subtitle,
      'phone': widget.contact,
      'totalDue': totalDue,
      'date': dateController.text,
    });

    controller.customerTransaction(widget.index, {
      'title': widget.title,
      'totalDue': totalDue,
      'sendAmount': sendAmount,
      'receiveAmount': receiveAmount,
      'date': dateController.text,
      'time': timeController.text,
      'description': descriptionController.text,
    });

    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(widget.subtitle, style: const TextStyle(color: Colors.grey, fontSize: 12)),
            Row(
              children: [
                const Icon(
                  Icons.call,
                  size: 12,
                  color: Colors.grey,
                ),
                const SizedBox(width: 8.0),
                Text(widget.contact, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ],
        ),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                child: const Row(
                  children: [
                    Icon(Icons.details),
                    Text('Report')
                  ],
                ),
                onTap: () {
                  Get.to(() => CustomerTransactionPage(customerIndex: widget.index));
                },
              ),
              PopupMenuItem(
                child: const Row(
                  children: [
                    Icon(Icons.delete_outline),
                    Text('Delete')
                  ],
                ),
                onTap: () {
                  sendController.clear();
                  receiveController.clear();
                  descriptionController.clear();
                },
              )
            ]
          ),
          const SizedBox(width: 12.0)
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Total Due : $totalDue',
                    style: const TextStyle(
                      color: Color(0xff448fc1),
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                const SizedBox( height: 38),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: TextFieldWidget(
                        keyboard: TextInputType.number,
                        title: 'Send :',
                        controller: sendController
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: TextFieldWidget(
                        keyboard: TextInputType.number,
                        title: 'Receive :',
                        controller: receiveController
                      ),
                    )
                  ],
                ),
                const SizedBox( height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: TextFieldWidget(
                        title: 'Date :',
                        controller: dateController
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: TextFieldWidget(
                        title: 'Time :',
                        controller: timeController
                      ),
                    )
                  ],
                ),
                const SizedBox( height: 18),
                TextFieldWidget(
                  title: 'Description :',
                  controller: descriptionController,
                  maxLine: 4,
                )
              ],
            ),
            const SizedBox( height: 32),
            ButtonWidget(
              title: 'Confirm',
              onPressed: updateTotalDue
            )
          ],
        ),
      )
    );
  }
}
