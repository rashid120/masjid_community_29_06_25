import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:masjid_community_29_06_25/view_models/user_details_view_model.dart';
import 'package:masjid_community_29_06_25/widgets/custom_button.dart';

class UserDetailsScreen extends StatelessWidget {
  const UserDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UserDetailsViewModel viewModel = Get.put(UserDetailsViewModel());
    final user = Get.arguments as Map<String, String>;

    return Scaffold(
      appBar: AppBar(
        title: Text('User Details'.tr),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(
              () => viewModel.isLoading.value
              ? _buildShimmerDetails()
              : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'User Information'.tr,
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const SizedBox(height: 16),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDetailRow('Name'.tr, user['name'] ?? 'Unknown'),
                      _buildDetailRow('Type'.tr, user['type'] ?? 'N/A'),
                      _buildDetailRow('Due Amount'.tr, user['dueAmount'] ?? '0'),
                      _buildDetailRow('Due Months'.tr, user['dueMonths'] ?? '0', color: _getDueColor(user['dueMonths'])),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Payment History'.tr,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: viewModel.paymentHistory.isEmpty
                    ? Center(child: Text('No Payment History'.tr))
                    : ListView.builder(
                  itemCount: viewModel.paymentHistory.length,
                  itemBuilder: (context, index) {
                    final payment = viewModel.paymentHistory[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        title: Text('Amount: ${payment['amount'] ?? 'N/A'}'.tr),
                        subtitle: Text(
                          'Method: ${payment['paymentMethod'] ?? 'N/A'} | Date: ${payment['dateTime']?.substring(0, 10) ?? 'N/A'}',
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              CustomButton(
                text: 'Update Payment Status'.tr,
                onPressed: () => viewModel.togglePaymentStatus(user['id'] ?? ''),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(
            value,
            style: TextStyle(color: color ?? Colors.black87),
          ),
        ],
      ),
    );
  }

  Color? _getDueColor(String? dueMonths) {
    final months = int.tryParse(dueMonths ?? '0') ?? 0;
    if (months == 1) return Colors.yellow[700];
    if (months >= 2) return Colors.red;
    return null;
  }

  Widget _buildShimmerDetails() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 30,
            width: 200,
            color: Colors.white,
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: List.generate(4, (index) => Container(
                  height: 20,
                  width: double.infinity,
                  color: Colors.white,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                )),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            height: 20,
            width: 150,
            color: Colors.white,
          ),
          const SizedBox(height: 8),
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