import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masjid_community_29_06_25/view_models/payment_view_model.dart';
import 'package:masjid_community_29_06_25/widgets/custom_button.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PaymentViewModel viewModel = Get.put(PaymentViewModel());

    return Scaffold(
      appBar: AppBar(
        title: Text('Make Payment'.tr),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Monthly Payment',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: viewModel.amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Amount'.tr,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                prefixIcon: const Icon(Icons.currency_rupee),
              ),
            ),
            const SizedBox(height: 16),
            Obx(
                  () => DropdownButton<String>(
                value: viewModel.paymentMethod.value.isEmpty ? null : viewModel.paymentMethod.value,
                hint: Text('Select Payment Method'.tr),
                isExpanded: true,
                items: viewModel.paymentMethods.map((String method) {
                  return DropdownMenuItem<String>(
                    value: method,
                    child: Text(method.tr),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    viewModel.setPaymentMethod(newValue);
                  }
                },
              ),
            ),
            const SizedBox(height: 16),
            Obx(
                  () => Row(
                children: [
                  Expanded(
                    child: RadioListTile<String>(
                      title: Text('Self'.tr),
                      value: 'Self',
                      groupValue: viewModel.paidBy.value,
                      onChanged: (String? value) {
                        if (value != null) {
                          viewModel.setPaidBy(value);
                        }
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      title: Text('Other'.tr),
                      value: 'Other',
                      groupValue: viewModel.paidBy.value,
                      onChanged: (String? value) {
                        if (value != null) {
                          viewModel.setPaidBy(value);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            Obx(
                  () => viewModel.paidBy.value == 'Other'
                  ? TextField(
                controller: viewModel.paidByNameController,
                decoration: InputDecoration(
                  labelText: 'Paid By Name'.tr,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  prefixIcon: const Icon(Icons.person),
                ),
              )
                  : const SizedBox.shrink(),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: viewModel.dueReasonController,
              decoration: InputDecoration(
                labelText: 'Due Reason (Optional)'.tr,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: viewModel.whenWillBePaidController,
              decoration: InputDecoration(
                labelText: 'When Will Be Paid (Optional)'.tr,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 20),
            Obx(
                  () => viewModel.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : CustomButton(
                text: 'Pay Now'.tr,
                onPressed: () => viewModel.processPayment(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}