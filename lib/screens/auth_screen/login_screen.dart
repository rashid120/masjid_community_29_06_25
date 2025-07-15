// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:masjid_community_29_06_25/utils/app_dimension.dart';
// import 'package:masjid_community_29_06_25/utils/resources/styles.dart';
// import '../view_models/auth_view_model.dart';
// import '../view_models/language_view_model.dart';
// import '../widgets/custom_button.dart';
//
// class LoginScreen extends StatelessWidget {
//   const LoginScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final AuthViewModel authViewModel = Get.put(AuthViewModel());
//     final LanguageController languageController = Get.put<LanguageController>(LanguageController());
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('welcome'.tr, style: Styles.appBarText(),),
//         actions: [
//           Obx(() => DropdownButton<Locale>(
//               value: languageController.selectedLocale.value,
//               icon: const Icon(Icons.language),
//               style: Styles.appBarActionText(),
//               items: const [
//                 DropdownMenuItem(value: Locale('en', 'US'), child: Text('English')),
//                 DropdownMenuItem(value: Locale('hi', 'IN'), child: Text('हिन्दी')),
//                 DropdownMenuItem(value: Locale('ur', 'PK'), child: Text('اردو')),
//               ],
//               onChanged: (Locale? newLocale) {
//                 if (newLocale != null) {
//                   languageController.changeLanguage(newLocale.languageCode, newLocale.countryCode!);
//                 }
//               },
//             ),
//           ),
//           SizedBox(width: 12,)
//         ],
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(Dimension.defaultScreenPadding),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'login_to_masjid'.tr,
//               style: Theme.of(context).textTheme.displayLarge,
//             ),
//             const SizedBox(height: 20),
//             TextField(
//               controller: authViewModel.emailController,
//               decoration: InputDecoration(
//                 labelText: 'email_or_phone'.tr,
//                 border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//                 prefixIcon: const Icon(Icons.person),
//               ),
//             ),
//             const SizedBox(height: 16),
//             Obx(() => TextField(
//                 controller: authViewModel.passwordController,
//                 obscureText: authViewModel.isPasswordHidden.value,
//                 decoration: InputDecoration(
//                   labelText: 'password'.tr,
//                   border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//                   prefixIcon: const Icon(Icons.lock),
//                   suffixIcon: IconButton(
//                     icon: Icon(authViewModel.isPasswordHidden.value ? Icons.visibility : Icons.visibility_off),
//                     onPressed: () => authViewModel.togglePasswordVisibility(),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             Obx(() => authViewModel.isLoading.value
//                   ? const CircularProgressIndicator()
//                   : CustomButton(
//                 text: 'Login',
//                 onPressed: () => authViewModel.login(),
//               ),
//             ),
//             const SizedBox(height: 16),
//             TextButton(
//               style: Theme.of(context).textButtonTheme.style,
//               onPressed: () => Get.toNamed('/signup'),
//               child: Text.rich(TextSpan(
//                 children: [
//                   TextSpan(text: "dont_have_account".tr),
//                   TextSpan(text: ' Sign Up', style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline))
//                 ]
//               )),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masjid_community_29_06_25/utils/resources/images.dart';
import 'package:masjid_community_29_06_25/widgets/custom_text_field.dart';
import '../../view_models/auth_view_model.dart';
import '../../view_models/language_view_model.dart';
import '../../widgets/custom_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  final AuthViewModel authViewModel = Get.put(AuthViewModel());
  final LanguageController languageController = Get.put(LanguageController());

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF232323),
      body: SafeArea(
        child: Column(
          children: [
            // App Logo
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Image.asset(
                Images.appLogoTransparent,
                height: 180,
                width: 400,
              ),
            ),
            Text('app_name'.tr, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),),
            const SizedBox(height: 20),
            // Theme and Language Options
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.end,
            //     children: [
            //       IconButton(
            //         icon: const Icon(Icons.language),
            //         onPressed: () {
            //           // Add language change logic or navigate to settings
            //           Get.bottomSheet(
            //             backgroundColor: Colors.grey.shade800,
            //             Container(
            //               padding: const EdgeInsets.all(16.0),
            //               child: Column(
            //                 mainAxisSize: MainAxisSize.min,
            //                 children: [
            //                   ListTile(
            //                     title: const Text('English'),
            //                     onTap: () => languageController.changeLanguage('en', 'US'),
            //                   ),
            //                   ListTile(
            //                     title: const Text('हिन्दी'),
            //                     onTap: () => languageController.changeLanguage('hi', 'IN'),
            //                   ),
            //                   ListTile(
            //                     title: const Text('اردو'),
            //                     onTap: () => languageController.changeLanguage('ur', 'PK'),
            //                   ),
            //                 ],
            //               ),
            //             ),
            //           );
            //         },
            //       ),
            //       IconButton(
            //         icon: const Icon(Icons.brightness_6),
            //         onPressed: () {
            //           // Toggle theme
            //           Get.changeTheme(Get.isDarkMode ? ThemeData.light() : ThemeData.dark());
            //           setState(() {
            //
            //           });
            //         },
            //       ),
            //     ],
            //   ),
            // ),
            Expanded(
              child: SlideTransition(
                position: _slideAnimation,
                child: Card(
                  color: Colors.white,
                  elevation: 10,
                  shadowColor: Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome Back'.tr,
                            style: TextStyle(fontSize: 28, color: Colors.black, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 7),
                          Text(
                            'Enter your details below'.tr,
                            style: TextStyle(fontSize: 14, color: Colors.black,),
                          ),
                          const SizedBox(height: 40),
                          CustomTextField(
                            controller: authViewModel.emailController,
                            prefixIcon: Icons.person,
                            hintText: 'email_or_phone'.tr,
                          ),

                          const SizedBox(height: 20),
                          Obx(() => CustomTextField(
                            isPassword: true,
                            controller: authViewModel.passwordController,
                            obscureText: authViewModel.isPasswordHidden.value,
                            hintText: 'password'.tr,
                            prefixIcon: Icons.lock,
                            suffixIcon: Icon(authViewModel.isPasswordHidden.value ? Icons.visibility : Icons.visibility_off),
                            onSuffixTap: () => authViewModel.togglePasswordVisibility(),
                          )),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(onPressed: () {

                            }, child: Text('Forgot password', style: TextStyle(color: Colors.black),)),
                          ),
                          const SizedBox(height: 20),
                          Obx(() => authViewModel.isLoading.value
                              ? const CircularProgressIndicator()
                              : CustomButton(
                            text: 'Login',
                            onPressed: () => authViewModel.login(),
                          ),),
                          const SizedBox(height: 10),
                          Divider(color: Colors.grey.shade200,),
                          TextButton(
                            style: Theme.of(context).textButtonTheme.style,
                            onPressed: () => Get.toNamed('/signup'),
                            child: Text.rich(TextSpan(
                                children: [
                                  TextSpan(text: "dont_have_account".tr, style: TextStyle(color: Colors.black)),
                                  TextSpan(text: ' Sign Up', style: TextStyle(color: Colors.blue, ))
                                ]
                            )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
