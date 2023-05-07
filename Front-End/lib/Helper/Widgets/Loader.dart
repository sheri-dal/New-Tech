import 'package:cancerrapp/Helper/Components/PrimaryText.dart';
import 'package:flutter/material.dart';

import '../Components/colors.dart';

class Loader extends StatelessWidget {
  final Color? backgroundColor;
  final Color? bcolor;
  final String? loadingText;
  final Color? txtColor;
  final double? txtsize;
  Loader(
      {Key? key,
      this.backgroundColor = Colors.grey,
      this.bcolor = Colors.blue,
      this.txtColor,
      this.txtsize,
      this.loadingText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: bcolor?.withOpacity(0.5),
            backgroundColor: backgroundColor,
          ),
          SizedBox(height: 10),
          PrimaryText(
            text: loadingText ?? "Loading",
            color: txtColor ?? AppColors.primary,
            size: txtsize ?? 20,
          )
        ],
      ),
    );
  }
}
