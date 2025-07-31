import 'package:flutter/material.dart';

class HomeWidget extends StatelessWidget {
  final String name;
  final String image;
  final VoidCallback onTap;
  const HomeWidget({super.key, required this.name, required this.image, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20),
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.network(image, width: 60, height: 60, fit: BoxFit.cover,),
            ),
            Text(name, style: TextStyle(overflow: TextOverflow.ellipsis),maxLines: 1,)
          ],
        ),
      ),
    );
  }
}
