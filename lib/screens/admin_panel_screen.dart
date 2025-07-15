import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:masjid_community_29_06_25/view_models/admin_panel_view_model.dart';

class AdminPanelScreen extends StatelessWidget {
  const AdminPanelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AdminPanelViewModel viewModel = Get.put(AdminPanelViewModel());

    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Panel'.tr),
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
                'User Management'.tr,
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const SizedBox(height: 16),
              // Status Summary
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildSummaryItem('Total Users'.tr, viewModel.totalUsers.value.toString()),
                      _buildSummaryItem('Total Paid'.tr, viewModel.totalPaid.value.toString()),
                      _buildSummaryItem('Total Unpaid'.tr, viewModel.totalUnpaid.value.toString()),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Search Bar
              TextField(
                controller: viewModel.searchController,
                decoration: InputDecoration(
                  labelText: 'Search Users'.tr,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  prefixIcon: const Icon(Icons.search),
                ),
                onChanged: (value) => viewModel.searchUsers(value),
              ),
              const SizedBox(height: 16),
              // User List
              Expanded(
                child: ListView.builder(
                  itemCount: viewModel.filteredUsers.length,
                  itemBuilder: (context, index) {
                    final user = viewModel.filteredUsers[index];
                    final dueMonths = int.tryParse(user['dueMonths'] ?? '0') ?? 0;
                    return Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: ListTile(
                        title: Text(
                          user['name'] ?? 'Unknown',
                          style: TextStyle(
                            color: dueMonths == 1
                                ? Colors.yellow[700]
                                : dueMonths >= 2
                                ? Colors.red
                                : Colors.black87,
                            decoration: dueMonths >= 3 ? TextDecoration.lineThrough : null,
                          ),
                        ),
                        subtitle: Text(
                          'Type: ${user['type'] ?? 'N/A'} | Due: ${user['dueAmount'] ?? '0'}',
                        ),
                        onTap: () => Get.toNamed('/user_details', arguments: user),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(
                                user['isPaid'] == 'true' ? Icons.check_circle : Icons.cancel,
                                color: user['isPaid'] == 'true' ? Colors.green : Colors.red,
                              ),
                              onPressed: () => viewModel.showPaymentDialog(context, user),
                            ),
                          ],
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

  Widget _buildSummaryItem(String label, String value) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontSize: 16)),
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
          const SizedBox(height: 16),
          Container(height: 50, color: Colors.white),
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