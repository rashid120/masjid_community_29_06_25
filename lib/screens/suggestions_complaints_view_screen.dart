import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:masjid_community_29_06_25/view_models/suggestions_complaints_view_view_model.dart';
import 'package:masjid_community_29_06_25/widgets/custom_button.dart';

class SuggestionsComplaintsViewScreen extends StatelessWidget {
  const SuggestionsComplaintsViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SuggestionsComplaintsViewViewModel viewModel = Get.put(SuggestionsComplaintsViewViewModel());

    return Scaffold(
      appBar: AppBar(
        title: Text('View Suggestions & Complaints'.tr),
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
                'Feedback List'.tr,
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: DropdownButton<String>(
                      value: viewModel.selectedRecipient.value.isEmpty ? null : viewModel.selectedRecipient.value,
                      hint: Text('Filter by Recipient'.tr),
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
                  const SizedBox(width: 16),
                  CustomButton(
                    text: 'Select Dates'.tr,
                    onPressed: () => viewModel.selectDateRange(context),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: viewModel.filteredFeedback.isEmpty
                    ? Center(child: Text('No Feedback Available'.tr))
                    : ListView.builder(
                  itemCount: viewModel.filteredFeedback.length,
                  itemBuilder: (context, index) {
                    final feedback = viewModel.filteredFeedback[index];
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