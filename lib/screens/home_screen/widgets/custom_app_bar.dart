import 'package:flutter/material.dart';
import 'package:masjid_community_29_06_25/widgets/urdu_date_widget.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
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
          UrduDateWidget(),
          Row(
            children: [
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
              SizedBox(width: 10,),
              CircleAvatar(
                radius: 15,
                backgroundImage: NetworkImage('https://img.freepik.com/premium-photo/drawing-boy-with-glasses-jacket-generative-ai_901242-11494.jpg'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
