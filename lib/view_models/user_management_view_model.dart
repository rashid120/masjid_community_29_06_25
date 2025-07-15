import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserManagementViewModel extends GetxController {
  var selectedFilters = <String>[].obs;
  var startDate = DateTime.now().subtract(const Duration(days: 30)).obs;
  var endDate = DateTime.now().obs;
  var users = <Map<String, String>>[].obs;
  var filteredUsers = <Map<String, String>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadUsers();
  }

  Future<void> loadUsers() async {
    // Simulate loading users from SharedPreferences or API
    final prefs = await SharedPreferences.getInstance();
    // Placeholder data
    users.value = [
      {'id': '1', 'name': 'Ali Khan', 'type': 'Regular', 'dueMonths': '0', 'dueAmount': '0', 'isPaid': 'true'},
      {'id': '2', 'name': 'Rahul Sharma', 'type': 'Regular', 'dueMonths': '1', 'dueAmount': '500', 'isPaid': 'false'},
      {'id': '3', 'name': 'Imran Ansari', 'type': 'Custom', 'dueMonths': '2', 'dueAmount': '1000', 'isPaid': 'false'},
      {'id': '4', 'name': 'Sara Ahmed', 'type': 'Regular', 'dueMonths': '3', 'dueAmount': '1500', 'isPaid': 'false'},
    ];
    filterUsers();
  }

  void toggleFilter(String filter) {
    if (selectedFilters.contains(filter)) {
      selectedFilters.remove(filter);
    } else {
      selectedFilters.add(filter);
    }
    filterUsers();
  }

  Future<void> selectDateRange(BuildContext context) async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      initialDateRange: DateTimeRange(start: startDate.value, end: endDate.value),
    );
    if (picked != null) {
      startDate.value = picked.start;
      endDate.value = picked.end;
      filterUsers();
    }
  }

  void filterUsers() {
    filteredUsers.value = users.where((user) {
      bool matchesType = selectedFilters.isEmpty ||
          (selectedFilters.contains('Regular') && user['type'] == 'Regular') ||
          (selectedFilters.contains('Custom') && user['type'] == 'Custom');
      bool matchesDue = selectedFilters.isEmpty ||
          (selectedFilters.contains('One Month Due') && user['dueMonths'] == '1') ||
          (selectedFilters.contains('More than One Month Due') && int.parse(user['dueMonths'] ?? '0') > 1);
      // Add date range filter if needed
      return matchesType && matchesDue;
    }).toList();
  }

  void togglePaymentStatus(String userId, bool isPaid) {
    final userIndex = users.indexWhere((u) => u['id'] == userId);
    if (userIndex != -1) {
      users[userIndex]['isPaid'] = isPaid.toString();
      filterUsers();
    }
  }
}