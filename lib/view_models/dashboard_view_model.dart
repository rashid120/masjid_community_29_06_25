import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardViewModel extends GetxController {
  var totalUsers = 0.obs;
  var pendingPayments = 0.obs;
  var recentFeedback = 0.obs;
  var recentFeedbackList = <Map<String, String>>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    isLoading.value = true;
    final prefs = await SharedPreferences.getInstance();

    // Load users
    final userList = prefs.getStringList('users') ?? [];
    totalUsers.value = userList.length;
    pendingPayments.value = userList.where((u) => eval(u)['isPaid'] == 'false').length;

    // Load recent feedback
    final feedbackData = prefs.getStringList('feedback') ?? [];
    recentFeedbackList.value = feedbackData.map((data) {
      final parts = data.split(': ');
      final dateTime = parts[0];
      final content = parts[1].split(' - ');
      return {
        'dateTime': dateTime,
        'recipient': content[0],
        'message': content[1],
      };
    }).toList();
    recentFeedback.value = recentFeedbackList.length;

    isLoading.value = false;
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