import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masjid_community_29_06_25/screens/home_screen/home_view_model.dart';
import 'package:masjid_community_29_06_25/screens/home_screen/widgets/custom_app_bar.dart';
import '../../view_models/auth_view_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeViewModel homeViewModel = Get.put(HomeViewModel());
    Get.lazyPut(()=>AuthViewModel());
    var size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size(size.width, size.height * 0.08),
            child: CustomAppbar()
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [

            ],
          ),
        ),
      ),
    );
  }
}