import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentViewModel extends GetxController {
  final amountController = TextEditingController();
  final paidByNameController = TextEditingController();
  final dueReasonController = TextEditingController();
  final whenWillBePaidController = TextEditingController();
  var paymentMethod = ''.obs;
  var paidBy = 'Self'.obs;
  var isLoading = false.obs;
  final List<String> paymentMethods = ['UPI', 'Cash', 'Card'];

  @override
  void onInit() {
    super.onInit();
    amountController.text = '500'; // Default amount (customize as needed)
  }

  void setPaymentMethod(String method) {
    paymentMethod.value = method;
  }

  void setPaidBy(String value) {
    paidBy.value = value;
  }

  Future<void> processPayment() async {
    if (amountController.text.isEmpty || paymentMethod.value.isEmpty || paidBy.value.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill all required fields.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }
    if (paidBy.value == 'Other' && paidByNameController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter the name of the person paying.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true;
    final prefs = await SharedPreferences.getInstance();
    final userName = prefs.getString('userName') ?? 'Unknown';
    final userId = prefs.getString('userId') ?? 'Unknown'; // Placeholder; set during login
    final paymentData = {
      'dateTime': DateTime.now().toIso8601String(),
      'userId': userId,
      'userName': userName,
      'amount': amountController.text,
      'paymentMethod': paymentMethod.value,
      'paidBy': paidBy.value == 'Self' ? userName : paidByNameController.text,
      'dueReason': dueReasonController.text,
      'whenWillBePaid': whenWillBePaidController.text,
    };

    // Simulate payment gateway (replace with actual integration, e.g., Razorpay)
    await Future.delayed(const Duration(seconds: 2));
    final paymentHistory = prefs.getStringList('paymentHistory') ?? [];
    paymentHistory.add(paymentData.toString());
    await prefs.setStringList('paymentHistory', paymentHistory);
    isLoading.value = false;

    Get.snackbar(
      'Success',
      'Payment processed successfully.',
      backgroundColor: const Color(0xFF1A3C34),
      colorText: Colors.white,
    );
    // Clear fields
    paidByNameController.clear();
    dueReasonController.clear();
    whenWillBePaidController.clear();
    paymentMethod.value = '';
    paidBy.value = 'Self';
  }

  @override
  void onClose() {
    amountController.dispose();
    paidByNameController.dispose();
    dueReasonController.dispose();
    whenWillBePaidController.dispose();
    super.onClose();
  }
}