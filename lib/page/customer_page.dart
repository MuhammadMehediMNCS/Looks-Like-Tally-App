import 'package:book_balance/controller/customer_controller.dart';
import 'package:book_balance/screen/customer_data_screen.dart';
import 'package:book_balance/screen/customer_detail_screen.dart';
import 'package:book_balance/screen/supplier_detail_screen.dart';
import 'package:book_balance/widget/expansion_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerPage extends StatefulWidget {
  const CustomerPage({super.key});

  @override
  State<CustomerPage> createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final CustomerController controller = Get.put(CustomerController());

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          children: [
            Obx(() {
              return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    const Text(
                      'Total Due',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)
                    ),
                    Text(
                      controller.totalDue.toString(),
                      style: const TextStyle(color: Color(0xff448fc1), fontSize: 24, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                const SizedBox(
                  height: 32,
                  child: VerticalDivider(
                    color: Colors.black,
                    thickness: 1.0
                  )
                ),
                Column(
                  children: [
                    const Text(
                      'Total Paid',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)
                    ),
                    Text(
                      controller.totalPaid.toString(),
                      style: const TextStyle(color: Color(0xff448fc1), fontSize: 24, fontWeight: FontWeight.bold),
                    )
                  ],
                )
              ],
            );
            }),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                width: 240,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: PreferredSize(
                        preferredSize: const Size.fromHeight(18.0),
                        child: SizedBox(
                          height: 18.0,
                          child: TabBar(
                            controller: _tabController,
                            indicator: const UnderlineTabIndicator(
                              borderSide: BorderSide(
                                color: Color(0xff448fc1),
                              ),
                              insets: EdgeInsets.symmetric(horizontal: 40.0),
                            ),
                            labelColor: Colors.black,
                            labelStyle: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold
                            ),
                            unselectedLabelColor: Colors.grey,
                            dividerHeight: 0.0,
                            tabs: const [
                              Text('Customer'),
                              Text('Supplier'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  Obx(() {
                    var sortedCustomers = controller.customers.toList();
                    sortedCustomers.sort((a, b) => (a['name'] ?? '').compareTo(b['name'] ?? ''));
                    return sortedCustomers.isEmpty ? const Center(
                      child: Text(
                        "Don't have any Customers",
                        style: TextStyle(color: Colors.grey, fontSize: 18.0),
                      ),
                    ) : ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: sortedCustomers.length,
                      itemBuilder: (context, index) {
                        return ExpansionTileWidget(
                          leading: sortedCustomers[index]['date'] ?? 'No Date',
                          title: sortedCustomers[index]['name'] ?? 'Name $index',
                          fathersName: sortedCustomers[index]['father'] ?? 'Father $index',
                          type: 'customer',
                          area: sortedCustomers[index]['area'] ?? 'Area $index',
                          icon: Icons.call,
                          contact: sortedCustomers[index]['phone'] ?? 'No Contact',
                          amount: sortedCustomers[index]['totalDue']?.toString() ?? '0.0',
                          edit: () {
                            Get.to(() => CustomerDetailScreen(
                              title: sortedCustomers[index]['name'] ?? 'Name $index',
                              subtitle: sortedCustomers[index]['area'] ?? 'Area $index',
                              contact: sortedCustomers[index]['phone'] ?? 'No Contact',
                              amount: sortedCustomers[index]['totalDue']?.toString() ?? '0.0',
                              index: index,
                            ));
                          },
                          delete: () {
                            Get.defaultDialog(
                              title: "Confirmation",
                              middleText: "Do you really want to delete this customer?",
                              textCancel: "No",
                              textConfirm: "Yes",
                              confirmTextColor: Colors.white,
                              onConfirm: () {
                                controller.removeCustomer(index);
                                Get.back();
                              },
                            );
                          },
                        );
                      },
                    );
                  }),
                  Obx(() {
                    var sortedSuppliers = controller.suppliers.toList();
                    sortedSuppliers.sort((a, b) => (a['name'] ?? '').compareTo(b['name'] ?? ''));
                    return sortedSuppliers.isEmpty ? const Center(
                      child: Text(
                        "Don't have any Suppliers",
                        style: TextStyle(color: Colors.grey, fontSize: 18.0),
                      ),
                    ) : ListView.builder(
                      itemCount: sortedSuppliers.length,
                      itemBuilder: (context, index) {
                        return ExpansionTileWidget(
                          leading: sortedSuppliers[index]['date'] ?? 'No Date',
                          title: sortedSuppliers[index]['name'] ?? 'Name $index',
                          fathersName: sortedSuppliers[index]['father'] ?? 'Father $index',
                          type: 'supplier',
                          area: sortedSuppliers[index]['area'] ?? 'Area $index',
                          icon: Icons.call,
                          contact: sortedSuppliers[index]['phone'] ?? 'No Contact',
                          amount: sortedSuppliers[index]['totalDue']?.toString() ?? '0.0',
                          edit: () {
                            Get.to(() => SupplierDetailScreen(
                              title: sortedSuppliers[index]['name'] ?? 'Name $index',
                              subtitle: sortedSuppliers[index]['area'] ?? 'Area $index',
                              contact: sortedSuppliers[index]['phone'] ?? 'No Contact',
                              amount: sortedSuppliers[index]['totalDue']?.toString() ?? '0.0',
                              index: index,
                            ));
                          },
                          delete: () {
                            Get.defaultDialog(
                              title: "Confirmation",
                              middleText: "Do you really want to delete this supplier?",
                              textCancel: "No",
                              textConfirm: "Yes",
                              confirmTextColor: Colors.white,
                              onConfirm: () {
                                controller.removeSupplier(index);
                                Get.back();
                              },
                            );
                          }
                        );
                      },
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        shape: const CircleBorder(),
        onPressed: () {
          Get.to(() => const CustomerDataScreen());
        },
        child: const Icon(
          Icons.person_add,
          color: Colors.white,
        ),
      ),
    );
  }
}