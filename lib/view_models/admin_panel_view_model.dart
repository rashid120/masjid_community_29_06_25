import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/custom_button.dart';

class AdminPanelViewModel extends GetxController {
  final searchController = TextEditingController();
  var users = <Map<String, String>>[].obs;
  var filteredUsers = <Map<String, String>>[].obs;
  var totalUsers = 0.obs;
  var totalPaid = 0.obs;
  var totalUnpaid = 0.obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadUsers();
  }

  Future<void> loadUsers() async {
    isLoading.value = true;
    final prefs = await SharedPreferences.getInstance();
    // Placeholder user data (replace with API)
    users.value = [
      {'id': '1', 'name': 'Ali Khan', 'type': 'Regular', 'dueMonths': '0', 'dueAmount': '0', 'isPaid': 'true'},
      {'id': '2', 'name': 'Rahul Sharma', 'type': 'Regular', 'dueMonths': '1', 'dueAmount': '500', 'isPaid': 'false'},
      {'id': '3', 'name': 'Imran Ansari', 'type': 'Custom', 'dueMonths': '2', 'dueAmount': '1000', 'isPaid': 'false'},
      {'id': '4', 'name': 'Sara Ahmed', 'type': 'Regular', 'dueMonths': '3', 'dueAmount': '1500', 'isPaid': 'false'},
    ];
    updateSummary();
    searchUsers('');
    isLoading.value = false;
  }

  void searchUsers(String query) {
    if (query.isEmpty) {
      filteredUsers.value = users;
    } else {
      filteredUsers.value = users.where((user) {
        final name = user['name']?.toLowerCase() ?? '';
        final id = user['id']?.toLowerCase() ?? '';
        return name.contains(query.toLowerCase()) || id.contains(query.toLowerCase());
      }).toList();
    }
  }

  void updateSummary() {
    totalUsers.value = users.length;
    totalPaid.value = users.where((user) => user['isPaid'] == 'true').length;
    totalUnpaid.value = users.where((user) => user['isPaid'] == 'false').length;
  }

  void showPaymentDialog(BuildContext context, Map<String, String> user) {
    final amountController = TextEditingController();
    bool isPaid = user['isPaid'] == 'true';
    Get.dialog(
      AlertDialog(
        title: Text('Set Payment Status'.tr),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('User: ${user['name'] ?? 'Unknown'}'),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Amount'.tr,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            SwitchListTile(
              title: Text(isPaid ? 'Paid'.tr : 'Unpaid'.tr),
              value: isPaid,
              onChanged: (value) => isPaid = value,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel'.tr),
          ),
          CustomButton(
            text: 'Save'.tr,
            onPressed: () async {
              await updatePaymentStatus(user['id'] ?? '', isPaid, amountController.text);
              Get.back();
            },
          ),
        ],
      ),
    );
  }

  Future<void> updatePaymentStatus(String userId, bool isPaid, String amount) async {
    final prefs = await SharedPreferences.getInstance();
    final userIndex = users.indexWhere((u) => u['id'] == userId);
    if (userIndex != -1) {
      users[userIndex]['isPaid'] = isPaid.toString();
      users[userIndex]['dueAmount'] = isPaid ? '0' : amount.isEmpty ? users[userIndex]['dueAmount'].toString() : amount.toString();
      users[userIndex]['dueMonths'] = isPaid ? '0' : users[userIndex]['dueMonths'].toString();
      await prefs.setStringList('users', users.map((u) => u.toString()).toList());
      updateSummary();
      searchUsers(searchController.text);
      Get.snackbar(
        'Success',
        'Payment status updated.',
        backgroundColor: const Color(0xFF1A3C34),
        colorText: Colors.white,
      );
    }
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}