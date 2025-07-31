import 'package:get/get.dart';
import 'package:masjid_community_29_06_25/screens/home_screen/home_view_model.dart';
import 'package:masjid_community_29_06_25/screens/user_profile_screen/user_profile_view_model.dart';
import 'package:masjid_community_29_06_25/view_models/profile_view_model.dart';
import '../screens/notes_screen/notes_view_model.dart';
import '../screens/users_status_screen/users_status_view_model.dart';

class AppBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => UsersStatusViewModel());
    Get.lazyPut(() => HomeViewModel());
    Get.lazyPut(() => ProfileViewModel());
    Get.lazyPut(() => NotesViewModel());
    Get.lazyPut(() => UserProfileViewModel());
  }
}