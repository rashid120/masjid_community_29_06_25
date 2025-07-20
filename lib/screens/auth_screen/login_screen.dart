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
