import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:masjid_community_29_06_25/utils/resources/animationRes.dart';
import 'package:masjid_community_29_06_25/view_models/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SplashController controller = Get.put(SplashController());
    return Scaffold(
      backgroundColor: const Color(0xFF1A3C34),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              AnimationRes.masjidAnimation,
              // width: 200,
              // height: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            Text(
              'app_name'.tr,
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'tagline'.tr,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.white70,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}