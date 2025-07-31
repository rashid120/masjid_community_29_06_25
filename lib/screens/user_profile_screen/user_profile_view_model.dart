import 'package:get/get.dart';

import '../../models/users_profile_data_model.dart';

class UserProfileViewModel extends GetxController{

  final dummyUser = UsersProfileDataModel(
    userId: "user_001",
    userName: "Rashid Ekbal",
    userImage: "https://example.com/images/user_001.jpg",
    isMember: true,
    isVerified: true,
    paidMonths: [
      MonthPayment(
        monthName: "January",
        amount: 100.0,
        isPaid: true,
        description: "Monthly donation",
        createdAt: DateTime.parse("2025-01-05"),
        updatedAt: DateTime.parse("2025-01-05"),
      ),
      MonthPayment(
        monthName: "February",
        amount: 100.0,
        isPaid: true,
        description: "Monthly donation",
        createdAt: DateTime.parse("2025-02-05"),
        updatedAt: DateTime.parse("2025-02-05"),
      ),
      MonthPayment(
        monthName: "March",
        amount: 100.0,
        isPaid: true,
        description: "Monthly donation",
        createdAt: DateTime.parse("2025-03-05"),
        updatedAt: DateTime.parse("2025-03-05"),
      ),
      MonthPayment(
        monthName: "April",
        amount: 100.0,
        isPaid: true,
        description: "Monthly donation",
        createdAt: DateTime.parse("2025-04-05"),
        updatedAt: DateTime.parse("2025-04-05"),
      ),
    ],
    unpaidMonths: [
      MonthPayment(
        monthName: "May",
        amount: 100.0,
        isPaid: false,
        description: "Not paid",
        createdAt: DateTime.parse("2025-05-01"),
        updatedAt: DateTime.parse("2025-05-01"),
      ),
      MonthPayment(
        monthName: "June",
        amount: 100.0,
        isPaid: false,
        description: "Not paid",
        createdAt: DateTime.parse("2025-06-01"),
        updatedAt: DateTime.parse("2025-06-01"),
      ),
      MonthPayment(
        monthName: "July",
        amount: 100.0,
        isPaid: false,
        description: "Not paid",
        createdAt: DateTime.parse("2025-07-01"),
        updatedAt: DateTime.parse("2025-07-01"),
      ),
    ],
    eventPayments: [
      EventPayment(
        eventName: "Eid Celebration",
        description: "Eid decoration and food",
        amount: 250.0,
        createdAt: DateTime.parse("2025-04-20"),
        updatedAt: DateTime.parse("2025-04-20"),
      ),
      EventPayment(
        eventName: "Ramadan Iftar",
        description: "Iftar meal arrangement",
        amount: 300.0,
        createdAt: DateTime.parse("2025-03-15"),
        updatedAt: DateTime.parse("2025-03-15"),
      ),
    ],
    totalPaidAmount: 400.0, // Jan to Apr
    totalDueAmount: 300.0,  // May to Jul
    totalEventPaidAmount: 550.0, // Eid + Iftar
    createdAt: DateTime.parse("2025-01-01"),
    updatedAt: DateTime.now(),
  );

  final Rx<UsersProfileDataModel?> _userData = Rx<UsersProfileDataModel?>(null);
  UsersProfileDataModel? get userData => _userData.value;

  void fetchUserData(String userId) {
    _userData.value = dummyUser; // jo tumne pehle bana rakha hai
    update();
  }

}