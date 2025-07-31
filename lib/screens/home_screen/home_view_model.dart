import 'package:get/get.dart';
import 'package:masjid_community_29_06_25/models/leaders_profile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/due_payment_model.dart';
import 'models/this_month_paid_model.dart';

class HomeViewModel extends GetxController {
  var isRegularUser = true.obs; // Placeholder; fetch from SharedPreferences


  List<LeadersProfile> leadersList = [
    LeadersProfile(
      id: 4,
      userId: 13,
      name: "مولانا فیصل احمد",
      image: "https://easy-peasy.ai/cdn-cgi/image/quality=70,format=auto,width=300/https://media.easy-peasy.ai/ae80b89b-84d4-4c66-a300-ad3fe86f9bde/9ff22fa3-1f80-4d54-b8ce-1b32e8310664.png",
      position: "Imam",
      about: "مولانا فیصل احمد ایک عالم دین ہیں جو مذہبی رہنمائی اور تعلیمات کے ذریعے کمیونٹی کو متحد رکھتے ہیں۔",
      createAt: "2024-04-01",
      updateAt: "2024-07-10",
    ),
    LeadersProfile(
      id: 1,
      userId: 10,
      name: "محمد اشفاق",
      image: "https://img.freepik.com/premium-photo/cartoon-illustration-male-muslim-people_1036975-33411.jpg",
      position: "Sadar",
      about: "محمد اشفاق ایک متحرک اور محنتی رہنما ہیں جنہوں نے ہمیشہ کمیونٹی کی خدمت کو اپنا مقصد بنایا۔ وہ سماجی ترقی اور اتحاد کے لیے کوشاں ہیں۔",
      createAt: "2024-01-01",
      updateAt: "2024-06-01",
    ),
    LeadersProfile(
      id: 2,
      userId: 11,
      name: "احمد خان",
      image: "https://img.freepik.com/premium-vector/serious-man-traditional-arabian-attire-colored-vector-illustration-cultural-representation_1057260-12358.jpg?w=2000",
      position: "Security",
      about: "احمد خان ایک ذمہ دار اور چوکنا رہنما ہیں جو کمیونٹی کی حفاظت کو یقینی بناتے ہیں۔ ان کی قائدانہ صلاحیتوں سے سب متاثر ہیں۔",
      createAt: "2024-02-01",
      updateAt: "2024-06-15",
    ),
    LeadersProfile(
      id: 3,
      userId: 12,
      name: "عبدالرحمن صدیقی",
      image: "https://www.shutterstock.com/image-vector/mohammad-bin-salman-vector-portrait-600nw-1270139458.jpg",
      position: "Khajanchi",
      about: "عبدالرحمن صدیقی مالیاتی معاملات میں مہارت رکھتے ہیں اور کمیونٹی کے مالی وسائل کو شفافیت کے ساتھ منظم کرتے ہیں۔",
      createAt: "2024-03-01",
      updateAt: "2024-07-01",
    ),

  ];

  List<DuePayment> duePaymentsList = [
    DuePayment(
      id: 1,
      userId: 10,
      months: "May 2025",
      amount: '150',
      dueFrom: '80',
      createAt: "2025-01-15",
      updateAd: "2025-07-15",
    ),
    DuePayment(
      id: 2,
      userId: 11,
      months: "Jun 2025",
      amount: "150",
      dueFrom: "50",
      createAt: "2025-01-15",
      updateAd: "2025-07-15",
    ),
    DuePayment(
      id: 3,
      userId: 12,
      months:"July 2025",
      amount: '150',
      dueFrom: "20",
      createAt: "2025-01-15",
      updateAd: "2025-07-15",
    ),
  ];

  List<ThisMonthPaid> thisMonthPaidsers = [
    ThisMonthPaid(
      id: 1,
      userId: 101,
      username: 'Rashid Khan',
      userImage: 'https://img.freepik.com/premium-photo/cartoon-illustration-male-muslim-people_1036975-33411.jpg',
      amount: '500',
      dateTime: '2025-07-01 10:00:00',
      createAt: '2025-07-01 09:50:00',
      updateAt: '2025-07-01 09:55:00',
    ),
    ThisMonthPaid(
      id: 2,
      userId: 102,
      username: 'Aamir Qureshi',
      userImage: 'https://img.freepik.com/premium-photo/cartoon-illustration-male-muslim-people_1036975-33411.jpg',
      amount: '700',
      dateTime: '2025-07-10 14:30:00',
      createAt: '2025-07-10 14:00:00',
      updateAt: '2025-07-10 14:10:00',
    ),
    ThisMonthPaid(
      id: 3,
      userId: 103,
      username: 'Faizan Ahmad',
      userImage: 'https://img.freepik.com/premium-photo/cartoon-illustration-male-muslim-people_1036975-33411.jpg',
      amount: '1000',
      dateTime: '2025-07-15 17:45:00',
      createAt: '2025-07-15 17:00:00',
      updateAt: '2025-07-15 17:10:00',
    ),
  ];


  @override
  void onInit() {
    super.onInit();
    _checkUserType();
  }

  Future<void> _checkUserType() async {
    final prefs = await SharedPreferences.getInstance();
    final userType = prefs.getString('userType') ?? 'Regular';
    isRegularUser.value = userType == 'Regular';
  }

  removeDueList(DuePayment model){
    duePaymentsList.removeWhere((element) => element == model,);
    update();
  }

  void viewProfile(String profileType) {
    // Navigate to profile screen (to be implemented)
    Get.toNamed('/profile/$profileType'); // Placeholder route
  }
}