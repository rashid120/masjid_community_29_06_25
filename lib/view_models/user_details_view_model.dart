import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDetailsViewModel extends GetxController {
  var isLoading = true.obs;
  var paymentHistory = <Map<String, String>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadPaymentHistory();
  }

  Future<void> loadPaymentHistory() async {
    isLoading.value = true;
    final prefs = await SharedPreferences.getInstance();
    final user = Get.arguments as Map<String, String>;
    final userId = user['id'] ?? '';
    final allPayments = prefs.getStringList('paymentHistory') ?? [];
    paymentHistory.value = allPayments
        .map((payment) => Map<String, String>.from(eval(payment)))
        .where((payment) => payment['userId'] == userId)
        .toList();
    isLoading.value = false;
  }

  Future<void> togglePaymentStatus(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final userList = prefs.getStringList('users') ?? [];
    final userIndex = userList.indexWhere((u) => u.contains(userId));
    if (userIndex != -1) {
      final userData = eval(userList[userIndex]);
      userData['isPaid'] = userData['isPaid'] == 'true' ? 'false' : 'true';
      userList[userIndex] = userData.toString();
      await prefs.setStringList('users', userList);
      Get.snackbar(
        'Success',
        'Payment status updated.',
        backgroundColor: const Color(0xFF1A3C34),
        colorText: Colors.white,
      );
    }
  }

  // Placeholder for parsing string to map (replace with proper JSON parsing)
  Map<String, dynamic> eval(String data) {
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