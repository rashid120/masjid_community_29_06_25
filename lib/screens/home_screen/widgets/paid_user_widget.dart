import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masjid_community_29_06_25/screens/home_screen/models/this_month_paid_model.dart';

import '../../../helper/route_helper.dart';

class ThisMonthPaidUserWidget extends StatelessWidget {
  final ThisMonthPaid paidUser;
  const ThisMonthPaidUserWidget({super.key, required this.paidUser});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(RouteHelper.getUserProfileScreen('0'));

      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.network(paidUser.userImage ?? '', width: 50, height: 50,),
          ),
          title: Text(
            paidUser.username ?? '',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            paidUser.dateTime ?? '',
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
          trailing: Text(
            '₹${paidUser.amount}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.green,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}

