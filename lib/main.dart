import 'package:book_balance/controller/customer_controller.dart';
import 'package:book_balance/controller/product_controller.dart';
import 'package:book_balance/controller/title_controller.dart';
import 'package:book_balance/page/calculator_page.dart';
import 'package:book_balance/page/cash_history_page.dart';
import 'package:book_balance/page/customer_page.dart';
import 'package:book_balance/page/product_info_page.dart';
import 'package:book_balance/screen/title_data_screen.dart';
import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:get/get.dart';

void main() {
  Get.put(CustomerController());
  Get.put(ProductController());
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<String> bottomTitles = ['Customer', 'Product Info', 'Cash History', 'Calculator'];

  final TitleController title = Get.put(TitleController());

  final List<Widget> pages = [
    const CustomerPage(),
    const ProductInfoPage(),
    const CashHistoryPage(),
    const CalculatorPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Get.to(const TitleDataScreen());
          },
          child: const Icon(Icons.dashboard_customize_outlined)
        ),
        title: Obx((){
          String appBarTitle = title.text.value.isEmpty ? 'Balance Book' : title.text.value;
          return Text(
            appBarTitle,
            style: const TextStyle(fontWeight: FontWeight.bold),
          );
        }),
        actions: [
          Text(
            bottomTitles[_currentIndex],
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 18.0),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search)
          ),
          const SizedBox(width: 12.0)
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            return Row(
              children: [
                NavigationRail(
                  backgroundColor: Colors.blue,
                  selectedIndex: _currentIndex,
                  onDestinationSelected: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  labelType: NavigationRailLabelType.selected,
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.groups),
                      label: Text(
                        'Customer',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.account_box),
                      label: Text(
                        'Product Info',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.monetization_on),
                      label: Text(
                        'Cash History',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.calculate),
                      label: Text(
                        'Calculator',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: pages[_currentIndex]
                )
              ],
            );
          } else {
            return Column(
              children: [
                Expanded(
                  child: pages[_currentIndex]
                ),
                BottomNavyBar(
                  backgroundColor: Colors.blue,
                  selectedIndex: _currentIndex,
                  itemCornerRadius: 24,
                  animationDuration: const Duration(milliseconds: 500),
                  onItemSelected: (index) => setState(() => _currentIndex = index),
                  items: <BottomNavyBarItem>[
                    BottomNavyBarItem(
                      icon: const Icon(Icons.groups),
                      title: const Text('Customer'),
                      activeColor: Colors.white,
                      textAlign: TextAlign.center,
                    ),
                    BottomNavyBarItem(
                      icon: const Icon(Icons.shopify),
                      title: const Text('Product Info'),
                      activeColor: Colors.white,
                      textAlign: TextAlign.center,
                    ),
                    BottomNavyBarItem(
                      icon: const Icon(Icons.wallet),
                      title: const Text('Cash History'),
                      activeColor: Colors.white,
                      textAlign: TextAlign.center,
                    ),
                    BottomNavyBarItem(
                      icon: const Icon(Icons.calculate),
                      title: const Text('Calculator'),
                      activeColor: Colors.white,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            );
          }
        },
      ),
    );
  }
}