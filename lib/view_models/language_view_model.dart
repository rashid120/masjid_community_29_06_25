import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageController extends GetxController {
  var selectedLocale = const Locale('en', 'US').obs;

  @override
  void onInit() {
    super.onInit();
    _loadSavedLanguage();
  }

  Future<void> _loadSavedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString('language_code') ?? 'en';
    final countryCode = prefs.getString('country_code') ?? 'US';
    selectedLocale.value = Locale(languageCode, countryCode);
    Get.updateLocale(selectedLocale.value);
  }

  Future<void> changeLanguage(String languageCode, String countryCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', languageCode);
    await prefs.setString('country_code', countryCode);
    selectedLocale.value = Locale(languageCode, countryCode);
    Get.updateLocale(selectedLocale.value);
  }
}