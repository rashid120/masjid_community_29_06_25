import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masjid_community_29_06_25/view_models/suggestions_complaints_view_model.dart';
import 'package:masjid_community_29_06_25/widgets/custom_button.dart';

class SuggestionsComplaintsScreen extends StatelessWidget {
  const SuggestionsComplaintsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SuggestionsComplaintsViewModel viewModel = Get.put(SuggestionsComplaintsViewModel());

    return Scaffold(
      appBar: AppBar(
        title: Text('Suggestions & Complaints'.tr),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Submit Your Feedback',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const SizedBox(height: 20),
            Obx(
                  () => DropdownButton<String>(
                value: viewModel.selectedRecipient.value.isEmpty
                    ? null
                    : viewModel.selectedRecipient.value,
                hint: Text('Select Recipient'.tr),
                isExpanded: true,
                items: viewModel.recipients.map((String recipient) {
                  return DropdownMenuItem<String>(
                    value: recipient,
                    child: Text(recipient.tr),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    viewModel.setRecipient(newValue);
                  }
                },
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: viewModel.messageController,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'Your Message'.tr,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                hintText: 'Enter your suggestion or complaint'.tr,
              ),
            ),
            const SizedBox(height: 20),
            Obx(
                  () => viewModel.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : CustomButton(
                text: 'Submit'.tr,
                onPressed: () => viewModel.submitFeedback(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}