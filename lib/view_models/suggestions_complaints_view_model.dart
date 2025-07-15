import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SuggestionsComplaintsViewModel extends GetxController {
  final messageController = TextEditingController();
  var selectedRecipient = ''.obs;
  var isLoading = false.obs;
  final List<String> recipients = [
    'Sadar',
    'Samiti',
    'Khajanchi',
    'Imam',
    'Gaw ke Log',
  ];

  void setRecipient(String recipient) {
    selectedRecipient.value = recipient;
  }

  Future<void> submitFeedback() async {
    if (selectedRecipient.value.isEmpty || messageController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please select a recipient and enter a message.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true;
    final prefs = await SharedPreferences.getInstance();
    // Simulate saving feedback (replace with API call later)
    final feedbackList = prefs.getStringList('feedback') ?? [];
    feedbackList.add(
      '${DateTime.now().toIso8601String()}: ${selectedRecipient.value} - ${messageController.text}',
    );
    await prefs.setStringList('feedback', feedbackList);
    isLoading.value = false;

    Get.snackbar(
      'Success',
      'Feedback submitted successfully.',
      backgroundColor: const Color(0xFF1A3C34),
      colorText: Colors.white,
    );
    messageController.clear();
    selectedRecipient.value = '';
  }

  @override
  void onClose() {
    messageController.dispose();
    super.onClose();
  }
}