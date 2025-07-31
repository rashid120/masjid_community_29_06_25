import 'package:get/get.dart';
import 'package:masjid_community_29_06_25/screens/news_screen/news_screen.dart';
import 'package:masjid_community_29_06_25/screens/notes_screen/notes_screen.dart';
import 'package:masjid_community_29_06_25/screens/splash_screen.dart';
import 'package:masjid_community_29_06_25/screens/user_profile_screen/user_profile_screen.dart';
import 'package:masjid_community_29_06_25/screens/users_status_screen/users_status_screen.dart';
import '../dashboard_screen.dart';
import '../screens/admin_panel_screen.dart';
import '../screens/dashboard_screen.dart';
import '../screens/home_screen/home_screen.dart';
import '../screens/auth_screen/login_screen.dart';
import '../screens/notifications_screen.dart';
import '../screens/payment_history_screen.dart';
import '../screens/payment_screen.dart';
import '../screens/profile_screen/profile_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/auth_screen/signup_screen.dart';
import '../screens/suggestions_complaints_screen.dart';
import '../screens/suggestions_complaints_view_screen.dart';
import '../screens/user_details_screen/user_details_screen.dart';
import '../screens/user_management_screen.dart';

class RouteHelper{

  static String initialPage = '/';
  static String dashboardScreen = '/dashboard_screen';
  static String signUp = '/signup';
  static String login = '/login';
  static String home = '/home';
  static String suggestionsComplaints = '/suggestions_complaints';
  static String payment = '/payment';
  static String paymentHistory = '/payment_history';
  static String userManagement = '/user_management';
  static String userDetails = '/user_details';
  static String adminPanel = '/admin_panel';
  static String profile = '/profile';
  static String suggestionsComplaintsView = '/suggestions_complaints_view';
  static String dashboardAdmin = '/dashboard_admin';
  static String notifications = '/notifications';
  static String settings = '/settings';
  static String newsScreen = '/news_screen';
  static String usersStatusScreen = '/users_status_screen';
  static String notesScreen = '/notes_screen';
  static String userProfileScreen = '/user_profile_screen';

  static String getInitialPage() => initialPage;
  static String getDashboardScreen() => dashboardScreen;
  static String getSignUpScreen() => signUp;
  static String getLoginScreen() => login;
  static String getHomeScreen() => home;
  static String getSuggestionsComplaintsScreen() => suggestionsComplaints;
  static String getPaymentScreen() => payment;
  static String getPaymentHistoryScreen() => paymentHistory;
  static String getUserManagementScreen() => userManagement;
  static String getUserDetailsScreen() => userDetails;
  static String getAdminPanelScreen() => adminPanel;
  static String getProfileScreen() => profile;
  static String getSuggestionsComplaintsViewScreen() => suggestionsComplaintsView;
  static String getDashboardAdminScreen() => dashboardAdmin;
  static String getNotificationsScreen() => notifications;
  static String getSettingsScreen() => settings;
  static String getNewsScreen() => newsScreen;
  static String getUsersStatusScreen() => usersStatusScreen;
  static String getNotesScreen() => notesScreen;
  static String getUserProfileScreen(String userId) => '$userProfileScreen?user_id=$userId';


  static Transition pagesTransition = Transition.topLevel;

  static List<GetPage> routes = [

    GetPage(name: initialPage, page:() => SplashScreen(), transition: pagesTransition),
    GetPage(name: login, page: () => const LoginScreen(), transition: pagesTransition),
    GetPage(name: signUp, page: () => const SignupScreen(), transition: pagesTransition),
    GetPage(name: home, page: () => const HomeScreen(), transition: pagesTransition),
    GetPage(name: suggestionsComplaints, page: () => const SuggestionsComplaintsScreen(), transition: pagesTransition),
    GetPage(name: payment, page: () => const PaymentScreen(), transition: pagesTransition),
    GetPage(name: paymentHistory, page: () => const PaymentHistoryScreen(), transition: pagesTransition),
    GetPage(name: userManagement, page: () => const UserManagementScreen(), transition: pagesTransition),
    GetPage(name: userDetails, page: () => const UserDetailsScreen(), transition: pagesTransition),
    GetPage(name: adminPanel, page: () => const AdminPanelScreen(), transition: pagesTransition),
    GetPage(name: profile, page: () => const ProfileScreen(), transition: pagesTransition),
    GetPage(name: suggestionsComplaintsView, page: () => const SuggestionsComplaintsViewScreen(), transition: pagesTransition),
    GetPage(name: dashboardAdmin, page: () => const DashboardScreenAdmin(), transition: pagesTransition),
    GetPage(name: dashboardScreen, page: () =>  DashboardScreen(pageIndex: 0,), transition: pagesTransition),
    GetPage(name: notifications, page: () => const NotificationsScreen(), transition: pagesTransition),
    GetPage(name: settings, page: () => const SettingsScreen(), transition: pagesTransition),
    GetPage(name: newsScreen, page: () => NewsScreen(), transition: pagesTransition),
    GetPage(name: usersStatusScreen, page: () => UsersStatusScreen(), transition: pagesTransition),
    GetPage(name: notesScreen, page: () => NotesScreen(), transition: pagesTransition),
    GetPage(name: userProfileScreen, page: () => UserProfileScreen(userId: Get.parameters['user_id'] ?? '',)),
  ];

}