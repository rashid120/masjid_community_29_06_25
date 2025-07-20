import 'package:flutter/material.dart';
import 'package:jhijri/jHijri.dart';

class UrduDateWidget extends StatelessWidget {
  const UrduDateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final hijri = HijriDate.now();

    String formattedDate = '${hijri.day}-${hijri.month}-${hijri.year}';
    String formattedDate1 = '${hijri.dayName} - ${hijri.monthName}';

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          formattedDate1,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
          textAlign: TextAlign.right,
        ),
        Container(
          width: 80,
          height: 1,
          color: Colors.grey,
        ),
        Text(
          formattedDate,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
          textAlign: TextAlign.right,
        ),
      ],
    );
  }
}
