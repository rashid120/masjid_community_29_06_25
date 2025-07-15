import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:masjid_community_29_06_25/view_models/notifications_view_model.dart';
import 'package:masjid_community_29_06_25/widgets/custom_button.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final NotificationsViewModel viewModel = Get.put(NotificationsViewModel());

    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'.tr),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(
              () => viewModel.isLoading.value
              ? _buildShimmer()
              : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Notifications'.tr,
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: DropdownButton<String>(
                      value: viewModel.selectedType.value.isEmpty ? null : viewModel.selectedType.value,
                      hint: Text('Filter by Type'.tr),
                      isExpanded: true,
                      items: viewModel.notificationTypes.map((String type) {
                        return DropdownMenuItem<String>(
                          value: type,
                          child: Text(type.tr),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          viewModel.setType(newValue);
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  CustomButton(
                    text: 'Select Dates'.tr,
                    onPressed: () => viewModel.selectDateRange(context),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: viewModel.filteredNotifications.isEmpty
                    ? Center(child: Text('No Notifications'.tr))
                    : ListView.builder(
                  itemCount: viewModel.filteredNotifications.length,
                  itemBuilder: (context, index) {
                    final notification = viewModel.filteredNotifications[index];
                    return Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: ListTile(
                        title: Text(
                          notification['title'] ?? 'Unknown',
                          style: TextStyle(
                            fontWeight: notification['isRead'] == 'true' ? FontWeight.normal : FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          '${notification['message'] ?? 'N/A'}\nDate: ${notification['dateTime']?.substring(0, 10) ?? 'N/A'}',
                        ),
                        trailing: notification['isRead'] == 'true'
                            ? null
                            : IconButton(
                          icon: const Icon(Icons.check_circle, color: Color(0xFF1A3C34)),
                          onPressed: () => viewModel.markAsRead(notification['id'] ?? ''),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
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
          Row(
            children: [
              Expanded(child: Container(height: 50, color: Colors.white)),
              const SizedBox(width: 16),
              Container(height: 50, width: 100, color: Colors.white),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) => Card(
                child: ListTile(
                  title: Container(height: 20, color: Colors.white),
                  subtitle: Container(height: 14, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}