import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masjid_community_29_06_25/helper/route_helper.dart';
import 'package:masjid_community_29_06_25/utils/resources/colors_res.dart';
import '../home_screen/widgets/custom_app_bar.dart';
import 'users_status_view_model.dart';

class UsersStatusScreen extends StatefulWidget {
  const UsersStatusScreen({super.key});

  @override
  State<UsersStatusScreen> createState() => _UsersStatusScreenState();
}

class _UsersStatusScreenState extends State<UsersStatusScreen> {

  @override
  void initState() {
    super.initState();
    Get.put(UsersStatusViewModel());
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(size.width, size.height * 0.08),
        child: const CustomAppbar(showDate: false, titleText: 'Status'),
      ),
      body: GetBuilder<UsersStatusViewModel>(builder: (controller) {
        return Column(
          children: [
            // Tab-like section with filters
            Container(
              margin: EdgeInsets.only(top: 5),
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              color: Theme.of(context).primaryColor.withOpacity(Get.isDarkMode ? 0.3 : 0.1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${controller.selectedStatus} members',
                    style: TextStyle(fontWeight: FontWeight.bold, color: ColorResTheme.textColor()),
                  ),
                  Row(
                    children: [
                      const SizedBox(width: 8), // Less gap
                      DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isDense: true,
                          value: controller.selectedMonth,
                          iconSize: 18, // Smaller arrow
                          alignment: Alignment.centerLeft,
                          style: TextStyle(fontSize: 14, color: ColorResTheme.subTitleTextColor()), // Smaller font
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          items: controller.months.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              controller.updateSelectedMonth(newValue);
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isDense: true,
                          value: controller.selectedStatus,
                          iconSize: 18,
                          alignment: Alignment.centerLeft,
                          style: TextStyle(fontSize: 14, color: ColorResTheme.subTitleTextColor()),
                          padding: const EdgeInsets.symmetric(horizontal: 0),
                          items: controller.statuses.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              controller.updateSelectedStatus(newValue);
                            }
                          },
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            ),
            // User cards list
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: controller.filteredUsers.length,
                itemBuilder: (context, index) {
                  final user = controller.filteredUsers[index];
                  return InkWell(
                    onTap: () {
                      Get.toNamed(RouteHelper.getUserProfileScreen('0'));
                    },
                    child: Card(
                      margin: const EdgeInsets.only(bottom: 12.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 24,
                          backgroundImage: NetworkImage(user.profileImageUrl ?? 'https://via.placeholder.com/50'),
                          child: user.profileImageUrl == null ? const Icon(Icons.person, color: Colors.white) : null,
                        ),
                        title: Text(user.name ?? 'Name'),
                        subtitle: Text('Rs/- ${user.amount ?? 150}'),
                        trailing: user.isPaid ?? false
                            ? const Icon(Icons.check_circle, color: Colors.green)
                            : const Text('Unpaid', style: TextStyle(color: Colors.red)),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}