import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ColorRes{
  static const Color primaryColor = Color(0xFF1A3C34);
  static const Color darkPrimaryColor = Color(0xFF23433A);
  static const Color secondaryColor = Color(0xFFF4A261);
  static const Color backgroundColor = Color(0xFFF8F8F8);


  static Color hintTextColor = Colors.grey.shade600;
  static const Color bgColor = Color(0xFF232323);
  static const Color cardBgColorDark = Color(0xFF1E1E1E);
  // static const Color cardBgColorLight = Color(0xFFEAE9E9);
  static const Color cardBgColorLight = Color(0xFFF5F5F5);


  static const Gradient dueCardGradient = LinearGradient(
    colors: [
      Color(0xFF2A2A2A),
      Color(0xFF27C14B),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );


}


class ColorResTheme{

  static Color cardBgColo() => Get.isDarkMode ? ColorRes.cardBgColorDark : ColorRes.cardBgColorLight;
  static Color textColor() => Get.isDarkMode ? Colors.white : Colors.black;
  static Color subTitleTextColor() => Get.isDarkMode ? Colors.white70 : Color(0xff6d6c6c);
  static Color miniTextColor() => Get.isDarkMode ? Colors.white70 : Color(0xff6b6b6b);
  static Color shadowColor() => Get.isDarkMode ? Colors.grey.withAlpha(30) : Colors.black.withAlpha(50);
  static Color premiumDividerColor() => Get.isDarkMode ? Colors.amber : Colors.amber.shade800;
  static Color paymentCardColor() => Get.isDarkMode ? Colors.black87 : Colors.black54;

}