import 'package:book_balance/controller/customer_controller.dart';
import 'package:book_balance/widget/button_widget.dart';
import 'package:book_balance/widget/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';


class CustomerDataScreen extends StatefulWidget {
  const CustomerDataScreen({super.key});

  @override
  State<CustomerDataScreen> createState() => _CustomerDataScreenState();
}

class _CustomerDataScreenState extends State<CustomerDataScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController fathersController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final CustomerController controller = Get.find<CustomerController>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    nameController.dispose();
    areaController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  void addItem(String type) {
    final newItem = {
      'name': nameController.text,
      'father': fathersController.text,
      'area': areaController.text,
      'phone': phoneController.text,
    };

    if (type == 'customer') {
      controller.addCustomer(newItem);
    } else {
      controller.addSupplier(newItem);
    }

    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'New Customer/Supplier',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(32.0),
          child: SizedBox(
            height: 32.0,
            child: TabBar(
              controller: _tabController,
              indicator: const UnderlineTabIndicator(
                borderSide: BorderSide(
                  color: Color(0xff448fc1),
                ),
                insets: EdgeInsets.symmetric(horizontal: 10.0),
              ),
              labelColor: const Color(0xff448fc1),
              labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              unselectedLabelColor: Colors.grey,
              tabs: const [
                Text('Customer'),
                Text('Supplier'),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          buildForm('customer'),
          buildForm('supplier'),
        ],
      ),
    );
  }

  Widget buildForm(String type) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              TextFieldWidget(
                title: 'Name :',
                controller: nameController
              ),
              const SizedBox(height: 24),
              TextFieldWidget(
                title: type == 'customer' ? "Father's Name :" : "Institute Name :",
                controller: fathersController
              ),
              const SizedBox(height: 24),
              TextFieldWidget(
                title: 'Area (Village/Town) :',
                controller: areaController
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: TextFieldWidget(
                      keyboard: TextInputType.phone,
                      title: 'Phone Number :',
                      controller: phoneController
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  IconButton(
                    onPressed: () async {
                      await pickContact();
                    },
                    icon: const Column(
                      children: [
                        Icon(Icons.person_add_alt_rounded),
                        Text('Phonebook', style: TextStyle(fontSize: 8.0, fontWeight: FontWeight.bold))
                      ],
                    )
                  )
                ],
              ),
            ],
          ),
          ButtonWidget(
            title: 'Confirm',
            onPressed: () => addItem(type)
          )
        ],
      ),
    );
  }
  Future<void> pickContact() async {
  // Request permission to access contacts
  if (await Permission.contacts.request().isGranted) {
    // Fetch contacts
    final Contact? contact = await ContactsService.openDeviceContactPicker();

    // Fill the phone number field with the selected contact's phone number
    if (contact != null && contact.phones!.isNotEmpty) {
      setState(() {
        phoneController.text = contact.phones!.first.value!;
      });
    }
  } else {
    // Show some error or information if permission is not granted
    Get.snackbar('Permission Denied', 'Please allow access to contacts');
  }
  }
}
