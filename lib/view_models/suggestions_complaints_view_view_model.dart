import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SuggestionsComplaintsViewViewModel extends GetxController {
  var selectedRecipient = ''.obs;
  var startDate = DateTime.now().subtract(const Duration(days: 30)).obs;
  var endDate = DateTime.now().obs;
  var feedbackList = <Map<String, String>>[].obs;
  var filteredFeedback = <Map<String, String>>[].obs;
  var isLoading = true.obs;
  final List<String> recipients = ['All', 'Sadar', 'Samiti', 'Khajanchi', 'Imam', 'Gaw ke Log'];

  @override
  void onInit() {
    super.onInit();
    loadFeedback();
  }

  Future<void> loadFeedback() async {
    isLoading.value = true;
    final prefs = await SharedPreferences.getInstance();
    final feedbackData = prefs.getStringList('feedback') ?? [];
    feedbackList.value = feedbackData.map((data) {
      // Simulate parsing feedback data
      final parts = data.split(': ');
      final dateTime = parts[0];
      final content = parts[1].split(' - ');
      return {
        'dateTime': dateTime,
        'recipient': content[0],
        'message': content[1],
      };
    }).toList();
    // Add sample data for testing
    feedbackList.addAll([
      {'dateTime': '2025-06-01T10:00:00Z', 'recipient': 'Sadar', 'message': 'Improve prayer facilities'},
      {'dateTime': '2025-06-02T12:00:00Z', 'recipient': 'Imam', 'message': 'Adjust sermon timings'},
    ]);
    filterFeedback();
    isLoading.value = false;
  }

  void setRecipient(String recipient) {
    selectedRecipient.value = recipient;
    filterFeedback();
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
      filterFeedback();
    }
  }

  void filterFeedback() {
    filteredFeedback.value = feedbackList.where((feedback) {
      final matchesRecipient = selectedRecipient.value == 'All' || feedback['recipient'] == selectedRecipient.value;
      final feedbackDate = DateTime.tryParse(feedback['dateTime'] ?? '') ?? DateTime.now();
      final matchesDate = feedbackDate.isAfter(startDate.value) && feedbackDate.isBefore(endDate.value.add(const Duration(days: 1)));
      return matchesRecipient && matchesDate;
    }).toList();
  }
}