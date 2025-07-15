import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masjid_community_29_06_25/helper/route_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthViewModel extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final masjidIdController = TextEditingController();
  var isPasswordHidden = true.obs;
  var isLoading = false.obs;
  var userType = 'Member'.obs;
  var isAuthenticated = false.obs;
  var userName = ''.obs;
  var userRole = ''.obs;
  var isAdmin = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkAuthStatus();
  }


  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  void setUserType(String type) {
    userType.value = type;
  }
  Future<void> checkAuthStatus() async {
    isLoading.value = true;
    final prefs = await SharedPreferences.getInstance();
    isAuthenticated.value = prefs.getBool('isAuthenticated') ?? false;
    if (isAuthenticated.value) {
      userName.value = prefs.getString('userName') ?? 'Unknown';
      userRole.value = prefs.getString('userRole') ?? '';
      isAdmin.value = ['Sadar', 'Samiti', 'Khajanchi', 'Imam'].contains(userRole.value);
    }
    isLoading.value = false;
  }

  Future<void> login() async {
    isLoading.value = true;
    final prefs = await SharedPreferences.getInstance();
    // Simulate login logic (replace with actual API call later)
    await Future.delayed(const Duration(seconds: 2));
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('userType', userType.value);
    await prefs.setBool('isAuthenticated', true);
    await prefs.setString('userName', 'User Name'); // Replace with actual user data
    await prefs.setString('userRole', 'Member'); // Replace with actual role
    isAuthenticated.value = true;
    userName.value = 'User Name';
    userRole.value = 'Member';
    isAdmin.value = ['Sadar', 'Samiti', 'Khajanchi', 'Imam'].contains(userRole.value);
    Get.snackbar(
      'Success',
      'Logged in successfully.',
      backgroundColor: const Color(0xFF1A3C34),
      colorText: Colors.white,
    );
    isLoading.value = false;
    Get.offNamed(RouteHelper.getDashboardScreen()); // Placeholder for home screen
  }

  Future<void> signup() async {
    isLoading.value = true;
    final prefs = await SharedPreferences.getInstance();
    // Simulate signup logic (replace with actual API call later)
    await Future.delayed(const Duration(seconds: 2));
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('userType', userType.value);
    await prefs.setString('userName', nameController.text);

    isLoading.value = false;
    Get.offNamed(RouteHelper.getDashboardScreen()); // Placeholder for home screen
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isAuthenticated', false);
    await prefs.remove('userName');
    await prefs.remove('userRole');
    isAuthenticated.value = false;
    userName.value = '';
    userRole.value = '';
    isAdmin.value = false;
    Get.snackbar(
      'Success',
      'Logged out successfully.',
      backgroundColor: const Color(0xFF1A3C34),
      colorText: Colors.white,
    );
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.onClose();
  }
}
