import 'package:flutter/material.dart';
import 'package:masjid_community_29_06_25/screens/home_screen/home_screen.dart';
import 'package:masjid_community_29_06_25/screens/news_screen/news_screen.dart';
import 'package:masjid_community_29_06_25/screens/profile_screen/profile_screen.dart';
import 'package:masjid_community_29_06_25/screens/users_status_screen/users_status_screen.dart';
import 'package:masjid_community_29_06_25/utils/resources/colors_res.dart';

class DashboardScreen extends StatefulWidget {
  final int pageIndex;
  const DashboardScreen({super.key, required this.pageIndex});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    currentPage = widget.pageIndex;
  }


  @override
  Widget build(BuildContext context) {

    return WillPopScope(child: Scaffold(
      body: getBody(),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(left: 16, right: 16, bottom: 16),
        decoration: BoxDecoration(
          color: ColorResTheme.cardBgColo(),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: ColorResTheme.shadowColor(),
              blurRadius: 8,
              offset: Offset(3, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Theme.of(context).primaryColor,
            unselectedItemColor: Colors.grey,      // unselected icon & label color
            // selectedLabelStyle: TextStyle(color: Colors.blue),
            unselectedLabelStyle: TextStyle(color: Colors.grey),
            backgroundColor: ColorResTheme.cardBgColo(),
            elevation: 2,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home',),
              BottomNavigationBarItem(icon: Icon(Icons.payment), label: 'Status',),
              BottomNavigationBarItem(icon: Icon(Icons.newspaper), label: 'News',),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile',),
            ],
            currentIndex: currentPage,
            onTap: (index) {
              setState(() {
                currentPage = index;
              });
            },
          ),
        ),
      ),
    ), onWillPop: () async{
      return true;
    },);
  }

  Widget getBody() {
    switch (currentPage) {
      case 0: return HomeScreen();
      // case 1: return SettingsScreen();
      case 1: return UsersStatusScreen();
      case 2: return NewsScreen();
      // case 2: return DashboardScreenAdmin();
      case 3: return ProfileScreen();
      default: return Center(child: Text('Invalid Screen'));
    }
  }
}
