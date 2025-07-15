import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masjid_community_29_06_25/view_models/home_view_model.dart';
import 'package:masjid_community_29_06_25/widgets/custom_button.dart';

import '../view_models/auth_view_model.dart';
import '../widgets/navigation_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeViewModel homeViewModel = Get.put(HomeViewModel());
    Get.lazyPut(()=>AuthViewModel());

    return Scaffold(
      appBar: AppBar(
        title: Text('welcome'.tr),
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: () {
              // Language selection handled in login screen; can add here if needed
            },
          ),
        ],
      ),
      drawer: const CustomNavigationDrawer(),
      body: Column(
        children: [
          // Common Header: Profile Icons
          Container(
            padding: const EdgeInsets.all(16),
            color: const Color(0xFF1A3C34),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildProfileIcon(context, 'Sadar', homeViewModel),
                _buildProfileIcon(context, 'Samiti', homeViewModel),
                _buildProfileIcon(context, 'Khajanchi', homeViewModel),
                _buildProfileIcon(context, 'Imam', homeViewModel),
              ],
            ),
          ),
          // Main Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Obx(
                    () => homeViewModel.isRegularUser.value
                    ? Column(
                  children: [
                    // Monthly Payment Card
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Text(
                              'Monthly Payment Due',
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Amount: ₹500', // Placeholder; fetch from ViewModel later
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const SizedBox(height: 16),
                            CustomButton(
                              text: 'Pay Now',
                              onPressed: () => Get.toNamed('/payment'), // Placeholder route
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Suggestions & Complaints Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomButton(
                          text: 'Suggestions',
                          onPressed: () => Get.toNamed('/suggestions'), // Placeholder route
                        ),
                        CustomButton(
                          text: 'Complaints',
                          onPressed: () => Get.toNamed('/complaints'), // Placeholder route
                        ),
                      ],
                    ),
                  ],
                )
                    : const Center(child: Text('Admin/Custom User View')), // Placeholder for other user types
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileIcon(BuildContext context, String title, HomeViewModel viewModel) {
    return GestureDetector(
      onTap: () => viewModel.viewProfile(title),
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: const Color(0xFFF4A261),
            child: Text(
              title[0],
              style: const TextStyle(fontSize: 24, color: Colors.white),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}