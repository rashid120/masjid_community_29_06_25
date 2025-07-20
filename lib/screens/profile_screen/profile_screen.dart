import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final ProfileViewModel viewModel = Get.put(ProfileViewModel());

    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40,),
            Center(child: Text('Profile'.tr, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
            const SizedBox(height: 20,),

            Expanded(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                color: Colors.white,
                child: Column(
                  children: [

                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(1.0),
                          child: ClipRRect(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10),),
                              child: Image.network('https://substackcdn.com/image/fetch/f_auto,q_auto:good,fl_progressive:steep/https://substack-post-media.s3.amazonaws.com/public/images/083be2c9-0e33-47b8-8bd9-42ba599ac7be_1280x720.png')
                          ),
                        ),
                        Positioned(
                          bottom: -50,
                          left: 10,
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.white, // outer white ring
                            child: Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: ClipOval(
                                child: Image.network(
                                  'https://wallpapers.com/images/hd/best-profile-pictures-7c4fnz0x5hts559b.jpg',
                                  width: 95,
                                  height: 95,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Rashid Khan', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),),
                            Text('Member', style: TextStyle(color: Colors.grey.shade800),),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Divider(color: Colors.grey.shade200,)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}