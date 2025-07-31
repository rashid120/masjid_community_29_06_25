import 'package:get/get.dart';
import '../../models/users_model.dart';

class UsersStatusViewModel extends GetxController {
  // Reactive properties
  var selectedMonth = 'Jul 25';
  var selectedStatus = 'All';
  var users = <UsersModel>[];

  // Available months and statuses for dropdowns
  final List<String> months = [
    'Jan 25',
    'Feb 25',
    'March 25',
    'April 25',
    'May 25',
    'Jun 25',
    'Jul 25',
  ];

  final List<String> statuses = ['All', 'Paid', 'Unpaid'];

  @override
  void onInit() {
    super.onInit();
    // Load dummy data
    loadDummyData();
  }

  // Method to load dummy data
  void loadDummyData() {
    final dummyUsers = [
      UsersModel(
        name: 'Ahmed Khan',
        amount: 150,
        isPaid: true,
        profileImageUrl:
        'https://as1.ftcdn.net/v2/jpg/06/49/60/84/1000_F_649608406_UXoddyZmqelIpRpSCYfJCTAf080qoVsc.jpg', // Placeholder image URL
      ),
      UsersModel(
        name: 'Fatima Ali',
        amount: 150,
        isPaid: false,
        profileImageUrl:
        'https://as1.ftcdn.net/v2/jpg/06/49/60/84/1000_F_649608406_UXoddyZmqelIpRpSCYfJCTAf080qoVsc.jpg', // Placeholder image URL
      ),
      UsersModel(
        name: 'Mohammed Siddiq',
        amount: 150,
        isPaid: true,
        profileImageUrl:
        'https://as1.ftcdn.net/v2/jpg/06/49/60/84/1000_F_649608406_UXoddyZmqelIpRpSCYfJCTAf080qoVsc.jpg', // Placeholder image URL
      ),
      UsersModel(
        name: 'Ayesha Begum',
        amount: 150,
        isPaid: false,
        profileImageUrl:
        'https://as1.ftcdn.net/v2/jpg/06/49/60/84/1000_F_649608406_UXoddyZmqelIpRpSCYfJCTAf080qoVsc.jpg', // Placeholder image URL
      ),
    ];
    users.assignAll(dummyUsers);
  }

  // Method to filter users based on selected status
  List<UsersModel> get filteredUsers {
    if (selectedStatus == 'All') {
      return users;
    } else if (selectedStatus == 'Paid') {
      return users.where((user) => user.isPaid == true).toList();
    } else {
      return users.where((user) => user.isPaid == false).toList();
    }
  }

  // Methods to update dropdown selections
  void updateSelectedMonth(String month) {
    selectedMonth = month;
    update();
  }

  void updateSelectedStatus(String status) {
    selectedStatus = status;
    update();
  }
}