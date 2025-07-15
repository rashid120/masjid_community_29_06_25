import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masjid_community_29_06_25/helper/route_helper.dart';
import 'package:masjid_community_29_06_25/utils/resources/colors_res.dart';
import '../../utils/resources/images.dart';
import '../../view_models/auth_view_model.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';


class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> with SingleTickerProviderStateMixin{

  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

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
    final AuthViewModel authViewModel = Get.find<AuthViewModel>();

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
                            'Sign Up to Get Started'.tr,
                            style: TextStyle(fontSize: 22, color: Colors.black, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 7),
                          Text(
                            'Enter your details below'.tr,
                            style: TextStyle(fontSize: 14, color: Colors.black,),
                          ),
                          const SizedBox(height: 40),
                          CustomTextField(
                            controller: authViewModel.emailController,
                            prefixIcon: Icons.email_outlined,
                            hintText: 'email_or_phone'.tr,

                          ),

                          const SizedBox(height: 20),
                          CustomTextField(
                            controller: authViewModel.nameController,
                            hintText: 'full_name'.tr,
                            prefixIcon: Icons.person_outline,

                          ),

                          const SizedBox(height: 20),
                          Obx(() => CustomTextField(
                            isPassword: true,
                            controller: authViewModel.passwordController,
                            obscureText: authViewModel.isPasswordHidden.value,
                            hintText: 'password'.tr,
                            prefixIcon: Icons.lock_outline,
                            suffixIcon: Icon(authViewModel.isPasswordHidden.value ? Icons.visibility : Icons.visibility_off),
                            onSuffixTap: () => authViewModel.togglePasswordVisibility(),
                          )),

                          const SizedBox(height: 20),
                          CustomTextField(
                            controller: authViewModel.masjidIdController,
                            hintText: 'Enter your masjid id'.tr,
                            prefixIcon: Icons.info_outline,
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Text('Select Your Role',style: TextStyle(fontWeight: FontWeight.bold, color: ColorRes.hintTextColor),),
                              const SizedBox(width: 10,),
                              Icon(Icons.info_outline, size: 18,color: ColorRes.hintTextColor,)
                            ],
                          ),
                          const SizedBox(height: 5,),
                          Obx(() => DropdownButton<String>(
                            value: authViewModel.userType.value,
                            hint: Text('Select User Type', style: TextStyle(color: ColorRes.hintTextColor),),
                            dropdownColor: Colors.grey,
                            icon: Icon(Icons.arrow_drop_down_circle_outlined, color: ColorRes.hintTextColor),
                            isExpanded: true,
                            items: ['Member', 'Visitor', 'Admin'].map((String type) {
                              return DropdownMenuItem<String>(
                                value: type,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(type, style: TextStyle(color: Colors.black),),
                                    Divider(color: Colors.grey[300], thickness: 1),
                                  ],
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                authViewModel.setUserType(newValue);
                              }
                            },
                          ),),
                          const SizedBox(height: 20),
                          Obx(() => authViewModel.isLoading.value
                              ? const CircularProgressIndicator()
                              : CustomButton(
                            text: 'Sign Up',
                            onPressed: () => authViewModel.signup(),
                          ),),
                          const SizedBox(height: 10),
                          Divider(color: Colors.grey.shade200,),
                          TextButton(
                            onPressed: () => Get.toNamed(RouteHelper.login),
                            child: Text.rich(TextSpan(
                                children: [
                                  TextSpan(text: "Already have an account?".tr, style: TextStyle(color: Colors.black)),
                                  TextSpan(text: ' Login', style: TextStyle(color: Colors.blue))
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