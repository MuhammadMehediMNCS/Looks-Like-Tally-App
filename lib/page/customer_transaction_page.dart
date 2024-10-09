import 'package:book_balance/controller/customer_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerTransactionPage extends StatefulWidget {
  final int customerIndex;

  const CustomerTransactionPage({
    Key? key,
    required this.customerIndex
  }) : super(key: key);

  @override
  State<CustomerTransactionPage> createState() => _CustomerTransactionPageState();
}

class _CustomerTransactionPageState extends State<CustomerTransactionPage> {
  final CustomerController controller = Get.find<CustomerController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() {
          final customer = controller.customers[widget.customerIndex];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                customer['name'] ?? '',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                'Total Due: ${customer['totalDue'] ?? 0.0}',
                style: const TextStyle(color: Color(0xff730505), fontSize: 10, fontWeight: FontWeight.bold),
              ),
            ],
          );
        }),
      ),
      body: Column(
        children: [
          buildHeader(),
          Expanded(
            child: Obx(() {
              final transactions = controller.customerTransactions[widget.customerIndex] ?? [];
              return ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  final transaction = transactions[index];
                  return Container(
                    decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(width: 2.0, color: Colors.grey)),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    transaction['date'] ?? '',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    transaction['time'] ?? '',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 10),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 18),
                              Text(
                                transaction['description'] ?? '',
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                maxLines: 4,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            transaction['sendAmount'].toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Color(0xff730505), fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            transaction['receiveAmount'].toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.green, fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }),
          ),
        ],
      )
    );
  }

  Widget buildHeader() => Container(
    decoration: const BoxDecoration(
      color: Colors.black12,
      border: Border(bottom: BorderSide(width: 2.0, color: Colors.grey),)
    ),
    child: const Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            'Transaction Details',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            'Sent',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            'Received',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ),
  );
}
