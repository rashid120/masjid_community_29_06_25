import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentHistoryViewModel extends GetxController {
  var selectedMonth = ''.obs;
  var showPaid = true.obs;
  var isLoading = true.obs;
  var filteredPayments = <Map<String, String>>[].obs;
  final List<String> months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];

  @override
  void onInit() {
    super.onInit();
    loadPayments();
  }

  Future<void> loadPayments() async {
    isLoading.value = true;
    final prefs = await SharedPreferences.getInstance();
    final paymentHistory = prefs.getStringList('paymentHistory') ?? [];
    // Simulate payment data with due statuses (replace with API later)
    filteredPayments.value = paymentHistory.map((payment) {
      final data = Map<String, String>.from(eval(payment)); // Placeholder parsing
      return data;
    }).toList();
    // Simulate due statuses
    filteredPayments.addAll([
      {'userName': 'Ali Khan', 'amount': '500', 'paymentMethod': 'UPI', 'dateTime': '2025-05-01T10:00:00Z', 'dueMonths': '1'},
      {'userName': 'Rahul Sharma', 'amount': '500', 'paymentMethod': 'Cash', 'dateTime': '2025-04-01T10:00:00Z', 'dueMonths': '2'},
      {'userName': 'Imran Ansari', 'amount': '500', 'paymentMethod': 'Card', 'dateTime': '2025-03-01T10:00:00Z', 'dueMonths': '3'},
    ]);
    filterPayments();
    isLoading.value = false;
  }

  void setMonth(String month) {
    selectedMonth.value = month;
    filterPayments();
  }

  void setShowPaid(bool value) {
    showPaid.value = value;
    filterPayments();
  }

  void filterPayments() {
    // Placeholder filtering logic; replace with actual API filtering
    filteredPayments.value = filteredPayments.where((payment) {
      final isPaid = payment['dueMonths'] == null || payment['dueMonths'] == '0';
      final matchesStatus = showPaid.value ? isPaid : !isPaid;
      final matchesMonth = selectedMonth.value.isEmpty ||
          (payment['dateTime']?.contains(selectedMonth.value) ?? false);
      return matchesStatus && matchesMonth;
    }).toList();
  }

  int getDueMonths(Map<String, String> payment) {
    return int.tryParse(payment['dueMonths'] ?? '0') ?? 0;
  }

  // Placeholder for parsing string to map (replace with proper JSON parsing)
  Map<String, dynamic> eval(String data) {
    // Simulated parsing; assumes data is stored as stringified map
    return Map<String, String>.from(
      Map.fromEntries(
        data.replaceAll('{', '').replaceAll('}', '').split(', ').map((e) {
          final parts = e.split(': ');
          return MapEntry(parts[0], parts[1]);
        }),
      ),
    );
  }
}