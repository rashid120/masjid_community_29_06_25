import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:masjid_community_29_06_25/view_models/settings_view_model.dart';
import 'package:masjid_community_29_06_25/widgets/custom_button.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SettingsViewModel viewModel = Get.put(SettingsViewModel());

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'.tr),
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
                  'Settings'.tr,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                const SizedBox(height: 16),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Language'.tr, style: Theme.of(context).textTheme.bodyLarge),
                        if(viewModel.languages.isNotEmpty)
                        DropdownButton<String>(
                          value: viewModel.selectedLanguage.value.toString(),
                          isExpanded: true,
                          items: viewModel.languageMap.entries.map((entry) {
                            return DropdownMenuItem<String>(
                              value: entry.key,
                              child: Text(entry.value.tr),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              viewModel.setLanguage(newValue);
                            }
                          },
                        ),
                        const SizedBox(height: 16),
                        Text('Theme'.tr, style: Theme.of(context).textTheme.bodyLarge),
                        DropdownButton<String>(
                          value: viewModel.selectedTheme.value,
                          isExpanded: true,
                          items: viewModel.themes.map((String theme) {
                            return DropdownMenuItem<String>(
                                value: theme,
                                child: Text(theme.tr),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              viewModel.setTheme(newValue);
                            }
                          },
                        ),
                        const SizedBox(height: 16),
                        Text('Notification Preferences'.tr, style: Theme.of(context).textTheme.bodyLarge),
                        SwitchListTile(
                          title: Text('Enable Payment Reminders'.tr),
                          value: viewModel.paymentRemindersEnabled.value,
                          onChanged: (value) => viewModel.setPaymentReminders(value),
                        ),
                        SwitchListTile(
                          title: Text('Enable Feedback Notifications'.tr),
                          value: viewModel.feedbackNotificationsEnabled.value,
                          onChanged: (value) => viewModel.setFeedbackNotifications(value),
                        ),
                        const SizedBox(height: 16),
                        CustomButton(
                          text: 'Save Settings'.tr,
                          onPressed: () => viewModel.saveSettings(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
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
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: List.generate(4, (index) => Container(
                  height: 50,
                  width: double.infinity,
                  color: Colors.white,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}