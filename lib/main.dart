import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masjid_community_29_06_25/dashboard_screen.dart';
import 'package:masjid_community_29_06_25/helper/route_helper.dart';
import 'package:masjid_community_29_06_25/screens/splash_screen.dart';
import 'package:masjid_community_29_06_25/utils/app_theme.dart';
import 'package:masjid_community_29_06_25/view_models/language_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:masjid_community_29_06_25/utils/localization/app_translations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() => SharedPreferences.getInstance());
  Get.put(LanguageController());
  runApp(const MasjidCommunityApp());
}

class MasjidCommunityApp extends StatelessWidget {
  const MasjidCommunityApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Masjid Community',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      locale: Get.locale ?? const Locale('en', 'US'),
      fallbackLocale: const Locale('en', 'US'),
      translations: AppTranslations(),
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('hi', 'IN'),
        Locale('ur', 'PK'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      initialRoute: RouteHelper.getInitialPage(),
      // home: SplashScreen(),
      home: DashboardScreen(pageIndex: 0,),
      getPages: RouteHelper.routes,
    );
  }
}