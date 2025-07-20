import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masjid_community_29_06_25/screens/profile_screen/widgets/options.dart';
import 'package:shimmer/shimmer.dart';

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
                child: SingleChildScrollView(
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
                      ,
                      Options()
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      // appBar: AppBar(
      //   title: Text('Profile'.tr),
      // ),

      // body: Padding(
      //   padding: const EdgeInsets.all(16.0),
      //   child: Obx(
      //         () => viewModel.isLoading.value
      //         ? _buildShimmer()
      //         : SingleChildScrollView(
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           Text(
      //             'User Information'.tr,
      //             style: Theme.of(context).textTheme.displayLarge,
      //           ),
      //           const SizedBox(height: 16),
      //           Card(
      //             elevation: 4,
      //             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      //             child: Padding(
      //               padding: const EdgeInsets.all(16.0),
      //               child: Column(
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 children: [
      //                   TextField(
      //                     controller: viewModel.nameController,
      //                     decoration: InputDecoration(
      //                       labelText: 'Name'.tr,
      //                       border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      //                     ),
      //                   ),
      //                   const SizedBox(height: 16),
      //                   TextField(
      //                     controller: viewModel.contactController,
      //                     keyboardType: TextInputType.phone,
      //                     decoration: InputDecoration(
      //                       labelText: 'Contact Number'.tr,
      //                       border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      //                     ),
      //                   ),
      //                   const SizedBox(height: 16),
      //                   Text('Type: ${viewModel.userType.value}'.tr),
      //                   const SizedBox(height: 16),
      //                   if (viewModel.isAdmin.value)
      //                     Text('Role: ${viewModel.userRole.value}'.tr),
      //                   const SizedBox(height: 16),
      //                   CustomButton(
      //                     text: 'Save Changes'.tr,
      //                     onPressed: () => viewModel.saveProfile(),
      //                   ),
      //                 ],
      //               ),
      //             ),
      //           ),
      //           const SizedBox(height: 20),
      //           Text(
      //             'Payment History'.tr,
      //             style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
      //           ),
      //           const SizedBox(height: 8),
      //           viewModel.paymentHistory.isEmpty
      //               ? Center(child: Text('No Payment History'.tr))
      //               : ListView.builder(
      //             shrinkWrap: true,
      //             physics: const NeverScrollableScrollPhysics(),
      //             itemCount: viewModel.paymentHistory.length,
      //             itemBuilder: (context, index) {
      //               final payment = viewModel.paymentHistory[index];
      //               return Card(
      //                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      //                 child: ListTile(
      //                   title: Text('Amount: ${payment['amount'] ?? 'N/A'}'.tr),
      //                   subtitle: Text(
      //                     'Method: ${payment['paymentMethod'] ?? 'N/A'} | Date: ${payment['dateTime']?.substring(0, 10) ?? 'N/A'}',
      //                   ),
      //                 ),
      //               );
      //             },
      //           ),
      //           if (viewModel.isAdmin.value) ...[
      //             const SizedBox(height: 20),
      //             Text(
      //               'Admin Options'.tr,
      //               style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
      //             ),
      //             const SizedBox(height: 8),
      //             CustomButton(
      //               text: 'View Suggestions'.tr,
      //               onPressed: () => viewModel.viewSuggestions(),
      //             ),
      //             const SizedBox(height: 8),
      //             CustomButton(
      //               text: 'View Complaints'.tr,
      //               onPressed: () => viewModel.viewComplaints(),
      //             ),
      //           ],
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
  
  Widget _buildShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(height: 30, width: 200, color: Colors.white),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: List.generate(3, (index) => Container(
                  height: 50,
                  width: double.infinity,
                  color: Colors.white,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                )),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(height: 20, width: 150, color: Colors.white),
          const SizedBox(height: 8),
          ListView.builder(
            shrinkWrap: true,
            itemCount: 3,
            itemBuilder: (context, index) => Card(
              child: ListTile(
                title: Container(height: 20, color: Colors.white),
                subtitle: Container(height: 14, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}