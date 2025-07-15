import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsViewModel extends GetxController {
  // var selectedLanguage = 'English'.obs;
  var selectedTheme = 'Light'.obs;
  var paymentRemindersEnabled = true.obs;
  var feedbackNotificationsEnabled = true.obs;
  var isLoading = true.obs;
  final List<String> languages = ['English', 'Hindi', 'Urdu'];
  final List<String> themes = ['Light', 'Dark'];
  final Map<String, String> languageMap = {
    'en_US': 'English',
    'hi_IN': 'Hindi',
    'ur_PK': 'Urdu',
  };

  var selectedLanguage = 'en_US'.obs;
  @override
  void onInit() {
    super.onInit();
    loadSettings();
  }

  Future<void> loadSettings() async {
    isLoading.value = true;
    final prefs = await SharedPreferences.getInstance();
    selectedLanguage.value = prefs.getString('language') ?? 'en_US';
    selectedTheme.value = prefs.getString('theme') ?? 'Light';
    paymentRemindersEnabled.value = prefs.getBool('paymentReminders') ?? true;
    feedbackNotificationsEnabled.value = prefs.getBool('feedbackNotifications') ?? true;
    isLoading.value = false;
  }

  void setLanguage(String language) {
    // selectedLanguage.value = language == 'English' ? 'en_US' : language == 'Hindi' ? 'hi_IN' : 'ur_PK';
    selectedLanguage.value = language;
  }

  void setTheme(String theme) {
    selectedTheme.value = theme;
  }

  void setPaymentReminders(bool value) {
    paymentRemindersEnabled.value = value;
  }

  void setFeedbackNotifications(bool value) {
    feedbackNotificationsEnabled.value = value;
  }

  Future<void> saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', selectedLanguage.value);
    await prefs.setString('theme', selectedTheme.value);
    await prefs.setBool('paymentReminders', paymentRemindersEnabled.value);
    await prefs.setBool('feedbackNotifications', feedbackNotificationsEnabled.value);

    // Update app language
    Get.updateLocale(Locale(selectedLanguage.value.split('_')[0], selectedLanguage.value.split('_')[1]));

    // Update app theme
    Get.changeThemeMode(selectedTheme.value == 'Light' ? ThemeMode.light : ThemeMode.dark);

    Get.snackbar(
      'Success',
      'Settings saved successfully.',
      backgroundColor: const Color(0xFF1A3C34),
      colorText: Colors.white,
    );
  }
}