import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masjid_community_29_06_25/view_models/user_management_view_model.dart';

class UserManagementScreen extends StatelessWidget {
  const UserManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UserManagementViewModel viewModel = Get.put(UserManagementViewModel());

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('User Management'.tr),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Paid'.tr),
              Tab(text: 'Unpaid'.tr),
            ],
          ),
        ),
        body: Column(
          children: [
            // Filter chips
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                spacing: 8.0,
                children: [
                  FilterChip(
                    label: Text('Regular'.tr),
                    selected: viewModel.selectedFilters.contains('Regular'),
                    onSelected: (selected) => viewModel.toggleFilter('Regular'),
                  ),
                  FilterChip(
                    label: Text('Custom'.tr),
                    selected: viewModel.selectedFilters.contains('Custom'),
                    onSelected: (selected) => viewModel.toggleFilter('Custom'),
                  ),
                  FilterChip(
                    label: Text('One Month Due'.tr),
                    selected: viewModel.selectedFilters.contains('One Month Due'),
                    onSelected: (selected) => viewModel.toggleFilter('One Month Due'),
                  ),
                  FilterChip(
                    label: Text('More than One Month Due'.tr),
                    selected: viewModel.selectedFilters.contains('More than One Month Due'),
                    onSelected: (selected) => viewModel.toggleFilter('More than One Month Due'),
                  ),
                ],
              ),
            ),
            // Date filter button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Date Range:'.tr),
                  TextButton(
                    onPressed: () => viewModel.selectDateRange(context),
                    child: Text('Select Dates'.tr),
                  ),
                ],
              ),
            ),
            // User list
            Expanded(
              child: TabBarView(
                children: [
                  _buildUserList(viewModel, true),
                  _buildUserList(viewModel, false),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserList(UserManagementViewModel viewModel, bool isPaid) {
    return Obx(
          () => ListView.builder(
        itemCount: viewModel.filteredUsers.length,
        itemBuilder: (context, index) {
          final user = viewModel.filteredUsers[index];
          if ((isPaid && user['isPaid'] == 'true') || (!isPaid && user['isPaid'] == 'false')) {
            final dueMonths = int.tryParse(user['dueMonths'] ?? '0') ?? 0;
            Color nameColor;
            TextDecoration decoration = TextDecoration.none;
            if (dueMonths == 1) {
              nameColor = Colors.yellow[700]!;
            } else if (dueMonths >= 2) {
              nameColor = Colors.red;
              if (dueMonths >= 3) {
                decoration = TextDecoration.lineThrough;
              }
            } else {
              nameColor = Colors.black87;
            }
            return Card(
              child: ListTile(
                title: Text(
                  user['name'] ?? 'Unknown',
                  style: TextStyle(
                    color: nameColor,
                    decoration: decoration,
                  ),
                ),
                subtitle: Text(
                  'Type: ${user['type'] ?? 'N/A'} | Due: ${user['dueAmount'] ?? '0'}',
                ),
                trailing: Switch(
                  value: user['isPaid'] == 'true',
                  onChanged: (value) => viewModel.togglePaymentStatus(user['id'].toString(), value),
                ),
                onTap: () => Get.toNamed('/user_details', arguments: user),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}