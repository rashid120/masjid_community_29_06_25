import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:masjid_community_29_06_25/view_models/auth_view_model.dart';

class CustomNavigationDrawer extends StatelessWidget {
  const CustomNavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthViewModel authViewModel = Get.put<AuthViewModel>(AuthViewModel());

    return Drawer(
      child: Obx(
            () => authViewModel.isLoading.value
            ? _buildShimmer()
            : ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xFF1A3C34),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    authViewModel.userName.value,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    authViewModel.userRole.value.isEmpty ? 'User'.tr : authViewModel.userRole.value.tr,
                    style: const TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: Text('Home'.tr),
              onTap: () => Get.offNamed('/home'),
            ),
            ListTile(
              leading: const Icon(Icons.feedback),
              title: Text('Suggestions & Complaints'.tr),
              onTap: () => Get.offNamed('/suggestions_complaints'),
            ),
            ListTile(
              leading: const Icon(Icons.payment),
              title: Text('Make Payment'.tr),
              onTap: () => Get.offNamed('/payment'),
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: Text('Payment History'.tr),
              onTap: () => Get.offNamed('/payment_history'),
            ),
            if (authViewModel.isAdmin.value) ...[
              ListTile(
                leading: const Icon(Icons.people),
                title: Text('User Management'.tr),
                onTap: () => Get.offNamed('/user_management'),
              ),
              ListTile(
                leading: const Icon(Icons.admin_panel_settings),
                title: Text('Admin Panel'.tr),
                onTap: () => Get.offNamed('/admin_panel'),
              ),
              ListTile(
                leading: const Icon(Icons.feedback_outlined),
                title: Text('View Suggestions & Complaints'.tr),
                onTap: () => Get.offNamed('/suggestions_complaints_view'),
              ),
              ListTile(
                leading: const Icon(Icons.dashboard),
                title: Text('Dashboard'.tr),
                onTap: () => Get.offNamed('/dashboard'),
              ),
            ],
            ListTile(
              leading: const Icon(Icons.notifications),
              title: Text('Notifications'.tr),
              onTap: () => Get.offNamed('/notifications'),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: Text('Profile'.tr),
              onTap: () => Get.offNamed('/profile'),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: Text('Settings'.tr),
              onTap: () => Get.offNamed('/settings'),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: Text('Logout'.tr),
              onTap: () {
                Get.dialog(
                  AlertDialog(
                    title: Text('Confirm Logout'.tr),
                    content: Text('Are you sure you want to logout?'.tr),
                    actions: [
                      TextButton(
                        onPressed: () => Get.back(),
                        child: Text('Cancel'.tr),
                      ),
                      TextButton(
                        onPressed: () {
                          authViewModel.logout();
                          Get.offAllNamed('/login');
                        },
                        child: Text('Logout'.tr),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 150,
            color: Colors.white,
          ),
          ...List.generate(6, (index) => ListTile(
            leading: Container(width: 24, height: 24, color: Colors.white),
            title: Container(height: 20, width: 100, color: Colors.white),
          )),
        ],
      ),
    );
  }
}