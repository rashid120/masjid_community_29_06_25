import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:masjid_community_29_06_25/helper/route_helper.dart';
import 'package:masjid_community_29_06_25/screens/home_screen/home_view_model.dart';
import 'package:masjid_community_29_06_25/screens/home_screen/widgets/custom_app_bar.dart';
import 'package:masjid_community_29_06_25/screens/home_screen/widgets/home_widget.dart';
import 'package:masjid_community_29_06_25/screens/home_screen/widgets/paid_user_widget.dart';
import 'package:masjid_community_29_06_25/utils/resources/animationRes.dart';
import 'package:masjid_community_29_06_25/widgets/due_card_widget.dart';
import 'package:masjid_community_29_06_25/widgets/leaders_card_widget.dart';
import '../../view_models/auth_view_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeViewModel homeViewModel = Get.put(HomeViewModel());
    Get.lazyPut(()=>AuthViewModel());
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(size.width, size.height * 0.08),
          child: CustomAppbar()
      ),
      body: GetBuilder<HomeViewModel>(builder: (controller) {
        return SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10,),

              SizedBox(
                height: 170,
                child: Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: homeViewModel.leadersList.length,
                    itemBuilder: (context, index) {
                      if(homeViewModel.leadersList.isNotEmpty){
                        var model = homeViewModel.leadersList[index];
                        return LeadersCardWidget(model: model);
                      }else{
                        return SizedBox.shrink();
                      }
                    },),
                ),
              ),

              Lottie.asset(AnimationRes.divider,repeat: false,height: 50, width: size.height * 0.5),

              if(homeViewModel.duePaymentsList.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: SizedBox(
                    height: 175,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: homeViewModel.duePaymentsList.length,
                      itemBuilder: (context, index) {
                        if(homeViewModel.duePaymentsList.isNotEmpty){
                          var dueModel = homeViewModel.duePaymentsList[index];
                          return DueCardWidget(duePayment: dueModel,);
                        }else{
                          return SizedBox.shrink();
                        }
                      },),
                  ),
                ),

              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 16),
                title: Text('Additional', style: TextStyle(fontWeight: FontWeight.bold),),
                trailing: TextButton(onPressed: () {

                }, child: Text('View more', style: TextStyle(color: Colors.blue),)),
              ),
              SizedBox(height: 10,),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HomeWidget(
                        name: 'Al Quran',
                        image: 'https://img.freepik.com/premium-photo/qur-sharif-with-light-coming-out-it-is-allah-writing-light_783716-2130.jpg',
                        onTap: (){}
                    ),
                    HomeWidget(
                        name: 'Study',
                        image: 'https://tse4.mm.bing.net/th/id/OIP.rGqpwVb5rqo8HKLlCX3D1AHaEj?rs=1&pid=ImgDetMain&o=7&rm=3',
                        onTap: (){}
                    ),
                    HomeWidget(
                        name: 'Hadith',
                        image: 'https://cdn.pixabay.com/photo/2018/10/11/02/18/islamic-book-3738793_1280.jpg',
                        onTap: (){}
                    ),
                    HomeWidget(
                        name: 'AI',
                        image: 'https://nykdaily.com/wp-content/uploads/2020/06/Human-AI-collaborations-best-for-skin-cancer-diagnosis.jpg',
                        onTap: (){}
                    ),
                    HomeWidget(
                        name: 'Urdu cal',
                        image: 'https://i.pinimg.com/originals/64/ff/bd/64ffbd980c3fcd1aac58c4bfb6676958.png',
                        onTap: (){}
                    ),
                    HomeWidget(
                        name: 'Notes',
                        image: 'https://th.bing.com/th/id/R.1207d3488a193ad4b3e34caf7e555286?rik=2zjJ7J%2fY%2fpKNNQ&riu=http%3a%2f%2fwww.s8wministries.org%2fimages%2ftheme%2fmy-notes.png&ehk=R7RV5YLuD2rpRUw3KdWckBnIpxYWOGJbrwH1nrFoHEA%3d&risl=&pid=ImgRaw&r=0',
                        onTap: (){
                          Get.toNamed(RouteHelper.getNotesScreen());
                        }
                    ),


                    SizedBox(width: 16,),
                  ],
                ),
              ),

              SizedBox(height: 16,),

              Align(alignment: Alignment.centerLeft,child: Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 10, bottom: 10),
                child: Text('Recently paid', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
              )),
              if(homeViewModel.thisMonthPaidsers.isNotEmpty)...[
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: homeViewModel.thisMonthPaidsers.length,
                  itemBuilder: (context, index) {
                    return ThisMonthPaidUserWidget(paidUser: homeViewModel.thisMonthPaidsers[index]);
                  },
                ),
                SizedBox(height: 10,)
              ]else
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text('User not found'),
                )

            ],
          ),
        );
      },),
    );
  }
}