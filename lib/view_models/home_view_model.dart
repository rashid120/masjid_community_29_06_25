import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeViewModel extends GetxController {
  var isRegularUser = true.obs; // Placeholder; fetch from SharedPreferences

  @override
  void onInit() {
    super.onInit();
    _checkUserType();
    _showDueNotification();
  }

  Future<void> _checkUserType() async {
    final prefs = await SharedPreferences.getInstance();
    final userType = prefs.getString('userType') ?? 'Regular';
    isRegularUser.value = userType == 'Regular';
  }

  void _showDueNotification() {
    // Show 5-second notification for regular users
    if (isRegularUser.value) {
      Future.delayed(Duration.zero, () {
        Get.snackbar(
          'Monthly Due Reminder',
          'Please submit your monthly payment.',
          duration: const Duration(seconds: 5),
          backgroundColor: const Color(0xFFF4A261),
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
      });
    }
  }

  void viewProfile(String profileType) {
    // Navigate to profile screen (to be implemented)
    Get.toNamed('/profile/$profileType'); // Placeholder route
  }
}