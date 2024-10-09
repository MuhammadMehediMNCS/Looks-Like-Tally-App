import 'package:get/get.dart';

class CustomerController extends GetxController {
  var customers = <Map<String, dynamic>>[].obs;
  var suppliers = <Map<String, dynamic>>[].obs;
  var customerTransactions = <int, List<Map<String, dynamic>>> {}.obs;
  var supplierTransactions = <int, List<Map<String, dynamic>>> {}.obs;

  double get totalDue => customers.fold(0.0, (sum, item) => sum + (item['totalDue'] ?? 0.0));
  double get totalPaid => suppliers.fold(0.0, (sum, item) => sum + (item['totalDue'] ?? 0.0));

  void addCustomer(Map<String, String> customer) {
    customers.add(customer);
  }

  void addSupplier(Map<String, String> supplier) {
    suppliers.add(supplier);
  }

  void removeCustomer(int index) {
    customers.removeAt(index);
  }

  void removeSupplier(int index) {
    suppliers.removeAt(index);
  }

  void updateCustomer(int index, Map<String, dynamic> updatedData) {
    customers[index] = updatedData;
    customers.refresh();
  }

  void updateSupplier(int index, Map<String, dynamic> updatedData) {
    suppliers[index] = updatedData;
    suppliers.refresh();
  }

  void customerTransaction(int index, Map<String, dynamic> transaction) {
    if (customerTransactions[index] == null) {
      customerTransactions[index] = [];
    }
    customerTransactions[index]!.add(transaction);
    customerTransactions.refresh();
  }

  void supplierTransaction(int index, Map<String, dynamic> transaction) {
    if (supplierTransactions[index] == null) {
      supplierTransactions[index] = [];
    }
    supplierTransactions[index]!.add(transaction);
    supplierTransactions.refresh();
  }
}
