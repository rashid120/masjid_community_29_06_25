import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? textColor;
  final Color? bgColor;
  final double? textSize;
  final double? height;

  const CustomButton({
    super.key, required this.text, required this.onPressed, this.textColor, this.textSize,
    this.height, this.bgColor
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: height,
      child: ElevatedButton(
        style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(bgColor)),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(fontSize: textSize ?? 16, fontWeight: FontWeight.w600, color: textColor),
        ),
      ),
    );
  }
}