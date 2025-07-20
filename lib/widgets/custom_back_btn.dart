import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBackBtn extends StatelessWidget {
  const CustomBackBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 50,
        left: 20,
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(50)
          ),
          child: InkWell(onTap: () {
            Get.back();
          },child: Icon(Icons.arrow_back_sharp)),
    ));
  }
}
