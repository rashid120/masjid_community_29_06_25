import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masjid_community_29_06_25/screens/home_screen/widgets/custom_app_bar.dart';
import 'package:masjid_community_29_06_25/screens/user_profile_screen/user_profile_view_model.dart';
import 'package:masjid_community_29_06_25/models/users_profile_data_model.dart'; // Make sure this path is correct

class UserProfileScreen extends StatefulWidget {
  final String userId;
  const UserProfileScreen({super.key, required this.userId});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  void initState() {
    super.initState();
    final viewModel = Get.put(UserProfileViewModel());
    viewModel.fetchUserData(widget.userId); // implement this in viewModel
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(size.width, size.height * 0.08),
        child: CustomAppbar(titleText: 'Profile', showDate: false, showLanguage: false),
      ),
      body: GetBuilder<UserProfileViewModel>(builder: (controller) {
        final user = controller.userData;
        if (user == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// Profile Section
              Row(
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundImage: NetworkImage(user.userImage ?? ''),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(user.userName ?? '', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Chip(
                              label: Text(user.isMember == true ? "Member" : "Non-Member"),
                              backgroundColor: user.isMember == true ? Colors.green.shade100 : Colors.red.shade100,
                            ),
                            const SizedBox(width: 8),
                            Chip(
                              label: Text(user.isVerified == true ? "Verified" : "Not Verified"),
                              backgroundColor: user.isVerified == true ? Colors.blue.shade100 : Colors.grey.shade300,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              /// Summary
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      SummaryTile(label: "Total Paid", amount: user.totalPaidAmount ?? 0),
                      SummaryTile(label: "Total Due", amount: user.totalDueAmount ?? 0),
                      SummaryTile(label: "Event Paid", amount: user.totalEventPaidAmount ?? 0),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              /// Paid Months
              SectionTitle(title: "Paid Months"),
              ...user.paidMonths?.map((e) => MonthTile(payment: e, isPaid: true)).toList() ?? [],

              const SizedBox(height: 24),

              /// Unpaid Months
              SectionTitle(title: "Unpaid Months"),
              ...user.unpaidMonths?.map((e) => MonthTile(payment: e, isPaid: false)).toList() ?? [],

              const SizedBox(height: 24),

              /// Events
              SectionTitle(title: "Event Payments"),
              ...user.eventPayments?.map((e) => ListTile(
                title: Text(e.eventName ?? ''),
                subtitle: Text(e.description ?? ''),
                trailing: Text("₹${e.amount?.toStringAsFixed(0) ?? '0'}"),
              )).toList() ?? [],
            ],
          ),
        );
      }),
    );
  }
}

class SummaryTile extends StatelessWidget {
  final String label;
  final double amount;
  const SummaryTile({super.key, required this.label, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 16)),
        Text("₹${amount.toStringAsFixed(0)}", style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
  }
}

class MonthTile extends StatelessWidget {
  final MonthPayment payment;
  final bool isPaid;
  const MonthTile({super.key, required this.payment, required this.isPaid});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(isPaid ? Icons.check_circle : Icons.cancel,
          color: isPaid ? Colors.green : Colors.red),
      title: Text(payment.monthName ?? ''),
      subtitle: Text(payment.description ?? ''),
      trailing: Text("₹${payment.amount?.toStringAsFixed(0) ?? '0'}"),
    );
  }
}
