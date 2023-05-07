import 'package:flutter/material.dart';

import 'colors.dart';

class PrimaryText extends StatelessWidget {
  final double size;
  final FontWeight fontWeight;
  final Color color;
  final String text;
  final double height;
  final TextAlign textAllign;

  const PrimaryText(
      {required this.text,
      this.fontWeight = FontWeight.w400,
      this.color = AppColors.primary,
      this.size = 20,
      this.height = 1.3,
      this.textAllign = TextAlign.center});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAllign,
      style: TextStyle(
        color: color,
        height: height,
        fontFamily: 'Poppins',
        fontSize: size,
        fontWeight: fontWeight,
      ),
    );
  }
}
