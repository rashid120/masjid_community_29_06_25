import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:masjid_community_29_06_25/widgets/urdu_date_widget.dart';

class CustomAppbar extends StatelessWidget {
  final bool showProfile;
  final bool showDate;
  final bool showLanguage;
  final String titleText;
  const CustomAppbar({
    super.key,
    this.showDate = true,
    this.showLanguage = true,
    this.showProfile = true,
    this.titleText = '',
  });

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle( SystemUiOverlayStyle(
      statusBarColor: Theme.of(context).primaryColor,
      statusBarIconBrightness: Brightness.light, // Use Brightness.light if the background image is dark
      statusBarBrightness: Brightness.light, // Optional, for iOS
    ));
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20),)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if(showDate)
              UrduDateWidget(),

              if(titleText == '' && !showDate)
              Expanded(child: SizedBox()),

            if(titleText != '')
              Align(alignment: Alignment.centerLeft,child: Text(titleText, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),)),
            Row(
              children: [
                if(showLanguage)
                InkWell(
                  onTap: () {
      
                  },
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.grey.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Icon(Icons.language_outlined, color: Colors.white),
                  ),
                ),
                if(showProfile)...[
                  SizedBox(width: 10,),
                  CircleAvatar(
                    radius: 15,
                    backgroundImage: NetworkImage('https://img.freepik.com/premium-photo/drawing-boy-with-glasses-jacket-generative-ai_901242-11494.jpg'),
                  ),
                ]
              ],
            )
          ],
        ),
      ),
    );
  }
}
