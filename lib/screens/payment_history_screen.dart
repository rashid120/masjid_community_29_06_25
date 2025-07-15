import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:masjid_community_29_06_25/view_models/payment_history_view_model.dart';

class PaymentHistoryScreen extends StatelessWidget {
  const PaymentHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PaymentHistoryViewModel viewModel = Get.put(PaymentHistoryViewModel());

    return Scaffold(
      appBar: AppBar(
        title: Text('Payment History'.tr),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Payment Records'.tr,
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Obx(
                        () => DropdownButton<String>(
                      value: viewModel.selectedMonth.value.isEmpty ? null : viewModel.selectedMonth.value,
                      hint: Text('Select Month'.tr),
                      isExpanded: true,
                      items: viewModel.months.map((String month) {
                        return DropdownMenuItem<String>(
                          value: month,
                          child: Text(month.tr),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          viewModel.setMonth(newValue);
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Obx(() => ToggleButtons(
                    isSelected: [
                      viewModel.showPaid.value,
                      !viewModel.showPaid.value,
                    ],
                    onPressed: (index) {
                      viewModel.setShowPaid(index == 0);
                    },
                    borderRadius: BorderRadius.circular(12),
                    selectedColor: Colors.white,
                    fillColor: const Color(0xFF1A3C34),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Text('Paid'.tr),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Text('Unpaid'.tr),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Obx(
                    () => viewModel.isLoading.value
                    ? _buildShimmerList()
                    : ListView.builder(
                  itemCount: viewModel.filteredPayments.length,
                  itemBuilder: (context, index) {
                    final payment = viewModel.filteredPayments[index];
                    final dueMonths = viewModel.getDueMonths(payment);
                    return Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        title: Text(
                          payment['userName'] ?? 'Unknown',
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
                          'Amount: ${payment['amount'] ?? 'N/A'} | Method: ${payment['paymentMethod'] ?? 'N/A'} | Date: ${payment['dateTime']?.substring(0, 10) ?? 'N/A'}',
                        ),
                        trailing: dueMonths > 0
                            ? Text(
                          'Due: $dueMonths month${dueMonths > 1 ? 's' : ''}',
                          style: TextStyle(
                            color: dueMonths == 1
                                ? Colors.yellow[700]
                                : Colors.red,
                          ),
                        )
                            : null,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerList() {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              title: Container(
                height: 20,
                color: Colors.white,
              ),
              subtitle: Container(
                height: 14,
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }
}