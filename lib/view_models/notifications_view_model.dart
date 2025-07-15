import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationsViewModel extends GetxController {
  var selectedType = ''.obs;
  var startDate = DateTime.now().subtract(const Duration(days: 30)).obs;
  var endDate = DateTime.now().obs;
  var notifications = <Map<String, String>>[].obs;
  var filteredNotifications = <Map<String, String>>[].obs;
  var isLoading = true.obs;
  final List<String> notificationTypes = ['All', 'Payment Reminder', 'New Feedback'];

  @override
  void onInit() {
    super.onInit();
    loadNotifications();
  }

  Future<void> loadNotifications() async {
    isLoading.value = true;
    final prefs = await SharedPreferences.getInstance();
    final notificationData = prefs.getStringList('notifications') ?? [];
    notifications.value = notificationData.map((data) {
      final parts = data.split(': ');
      final id = parts[0];
      final content = parts[1].split(' - ');
      return {
        'id': id,
        'title': content[0],
        'message': content[1],
        'type': content[2],
        'dateTime': content[3],
        'isRead': content[4],
      };
    }).toList();
    // Add sample data for testing
    notifications.addAll([
      {
        'id': '1',
        'title': 'Payment Reminder',
        'message': 'Your payment of 500 is due.',
        'type': 'Payment Reminder',
        'dateTime': '2025-06-28T10:00:00Z',
        'isRead': 'false',
      },
      {
        'id': '2',
        'title': 'New Feedback',
        'message': 'New suggestion received for Sadar.',
        'type': 'New Feedback',
        'dateTime': '2025-06-29T12:00:00Z',
        'isRead': 'false',
      },
    ]);
    filterNotifications();
    isLoading.value = false;
  }

  void setType(String type) {
    selectedType.value = type;
    filterNotifications();
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
      filterNotifications();
    }
  }

  void filterNotifications() {
    filteredNotifications.value = notifications.where((notification) {
      final matchesType = selectedType.value == 'All' || notification['type'] == selectedType.value;
      final notificationDate = DateTime.tryParse(notification['dateTime'] ?? '') ?? DateTime.now();
      final matchesDate = notificationDate.isAfter(startDate.value) && notificationDate.isBefore(endDate.value.add(const Duration(days: 1)));
      return matchesType && matchesDate;
    }).toList();
  }

  Future<void> markAsRead(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final notificationIndex = notifications.indexWhere((n) => n['id'] == id);
    if (notificationIndex != -1) {
      notifications[notificationIndex]['isRead'] = 'true';
      await prefs.setStringList('notifications', notifications.map((n) => '${n['id']}: ${n['title']} - ${n['message']} - ${n['type']} - ${n['dateTime']} - ${n['isRead']}').toList());
      filterNotifications();
      Get.snackbar(
        'Success',
        'Notification marked as read.',
        backgroundColor: const Color(0xFF1A3C34),
        colorText: Colors.white,
      );
    }
  }
}