import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:masjid_community_29_06_25/view_models/dashboard_view_model.dart';
import 'package:masjid_community_29_06_25/widgets/custom_button.dart';

class DashboardScreenAdmin extends StatelessWidget {
  const DashboardScreenAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    final DashboardViewModel viewModel = Get.put(DashboardViewModel());

    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'.tr),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(
              () => viewModel.isLoading.value
              ? _buildShimmer()
              : SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Overview'.tr,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                const SizedBox(height: 16),
                // Metrics Section
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildMetricCard('Total Users'.tr, viewModel.totalUsers.value.toString()),
                        _buildMetricCard('Pending Payments'.tr, viewModel.pendingPayments.value.toString()),
                        _buildMetricCard('Recent Feedback'.tr, viewModel.recentFeedback.value.toString()),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Quick Navigation
                Text(
                  'Quick Actions'.tr,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    CustomButton(
                      text: 'Manage Users'.tr,
                      onPressed: () => Get.toNamed('/user_management'),
                    ),
                    CustomButton(
                      text: 'Payment History'.tr,
                      onPressed: () => Get.toNamed('/payment_history'),
                    ),
                    CustomButton(
                      text: 'View Suggestions & Complaints'.tr,
                      onPressed: () => Get.toNamed('/suggestions_complaints_view'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Recent Feedback
                Text(
                  'Recent Feedback'.tr,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                viewModel.recentFeedbackList.isEmpty
                    ? Center(child: Text('No Feedback Available'.tr))
                    : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: viewModel.recentFeedbackList.length,
                  itemBuilder: (context, index) {
                    final feedback = viewModel.recentFeedbackList[index];
                    return Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: ListTile(
                        title: Text(feedback['recipient'] ?? 'Unknown'),
                        subtitle: Text(
                          '${feedback['message'] ?? 'N/A'}\nDate: ${feedback['dateTime']?.substring(0, 10) ?? 'N/A'}',
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMetricCard(String title, String value) {
    return Column(
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontSize: 16, color: Color(0xFF1A3C34))),
      ],
    );
  }

  Widget _buildShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(height: 30, width: 200, color: Colors.white),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(3, (index) => Container(
                  height: 40,
                  width: 80,
                  color: Colors.white,
                )),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(height: 20, width: 150, color: Colors.white),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: List.generate(3, (index) => Container(
              height: 50,
              width: 120,
              color: Colors.white,
            )),
          ),
          const SizedBox(height: 20),
          Container(height: 20, width: 150, color: Colors.white),
          const SizedBox(height: 8),
          ListView.builder(
            shrinkWrap: true,
            itemCount: 3,
            itemBuilder: (context, index) => Card(
              child: ListTile(
                title: Container(height: 20, color: Colors.white),
                subtitle: Container(height: 14, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}