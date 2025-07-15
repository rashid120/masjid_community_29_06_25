import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileViewModel extends GetxController {
  final nameController = TextEditingController();
  final contactController = TextEditingController();
  var userType = 'Regular'.obs;
  var userRole = ''.obs;
  var isAdmin = false.obs;
  var paymentHistory = <Map<String, String>>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadProfile();
  }

  Future<void> loadProfile() async {
    isLoading.value = true;
    final prefs = await SharedPreferences.getInstance();
    nameController.text = prefs.getString('userName') ?? 'Unknown';
    contactController.text = prefs.getString('userContact') ?? '';
    userType.value = prefs.getString('userType') ?? 'Regular';
    userRole.value = prefs.getString('userRole') ?? '';
    isAdmin.value = ['Sadar', 'Samiti', 'Khajanchi', 'Imam'].contains(userRole.value);

    final userId = prefs.getString('userId') ?? '';
    final allPayments = prefs.getStringList('paymentHistory') ?? [];
    paymentHistory.value = allPayments
        .map((payment) => Map<String, String>.from(eval(payment)))
        .where((payment) => payment['userId'] == userId)
        .toList();
    isLoading.value = false;
  }

  Future<void> saveProfile() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', nameController.text);
    await prefs.setString('userContact', contactController.text);
    Get.snackbar(
      'Success',
      'Profile updated successfully.',
      backgroundColor: const Color(0xFF1A3C34),
      colorText: Colors.white,
    );
  }

  void viewSuggestions() {
    // Placeholder for viewing suggestions (future screen or dialog)
    Get.snackbar(
      'Info',
      'Suggestions view not implemented yet.',
      backgroundColor: const Color(0xFF1A3C34),
      colorText: Colors.white,
    );
  }

  void viewComplaints() {
    // Placeholder for viewing complaints (future screen or dialog)
    Get.snackbar(
      'Info',
      'Complaints view not implemented yet.',
      backgroundColor: const Color(0xFF1A3C34),
      colorText: Colors.white,
    );
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

  @override
  void onClose() {
    nameController.dispose();
    contactController.dispose();
    super.onClose();
  }
}