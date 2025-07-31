import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masjid_community_29_06_25/models/due_payment_model.dart';
import 'package:masjid_community_29_06_25/screens/home_screen/home_view_model.dart';
import 'package:masjid_community_29_06_25/utils/resources/colors_res.dart';
import 'package:masjid_community_29_06_25/widgets/custom_button.dart';

class DueCardWidget extends StatelessWidget {
  final DuePayment duePayment;
  const DueCardWidget({super.key, required this.duePayment});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16, bottom: 10),
      width: MediaQuery.of(context).size.width * 0.9,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: ColorRes.dueCardGradient,
        boxShadow: [
          BoxShadow(
            color: Colors.white.withAlpha(50),
            blurRadius: 2,
            offset: const Offset(0, 1),
            blurStyle: BlurStyle.outer,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row: Month (left) and Due in X days (right)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                duePayment.months ?? '',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                'Due in ${duePayment.dueFrom} days',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),

          // Bottom Left: Indian Rupee symbol and amount
          Text(
            '₹ ${duePayment.amount}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),

          CustomButton(
            height: 45,
            textSize: 16,
            bgColor: Color(0xFF27C14B),
            // bgColor: Colors.amber,
            textColor: Colors.white,
            text: 'Pay now', onPressed: () async{
              Get.find<HomeViewModel>().removeDueList(duePayment);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Pay Now clicked for ${duePayment.months}')),
              );
          },)
        ],
      ),
    );
  }
}