import 'package:cancerrapp/Helper/Components/PrimaryText.dart';
import 'package:cancerrapp/Helper/Components/colors.dart';
import 'package:cancerrapp/Helper/Widgets/Loader.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String buttonName;
  final Color btnColor;
  final Color btntrxtcolor;
  final Color btnBordercolor;
  final bool isLoading;
  final double bthHeight;
  final double? bthWidth;
  final double? btnTextSize;
  final GestureTapCallback onPressed;
  final BorderRadiusGeometry? btnborder;
  final EdgeInsetsGeometry? margin;
  const MyButton(
      {Key? key,
      required this.buttonName,
      this.isLoading = false,
      this.btnColor = AppColors.primary,
      this.btntrxtcolor = Colors.white,
      this.btnBordercolor = Colors.transparent,
      this.bthHeight = 40,
      this.btnborder,
      this.margin,
      this.bthWidth,
      this.btnTextSize,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: margin ?? EdgeInsets.symmetric(horizontal: 13, vertical: 7),
        height: bthHeight,
        width: bthWidth ?? double.infinity,
        decoration: BoxDecoration(
            color: btnColor,
            borderRadius: btnborder ?? BorderRadius.circular(20),
            border: Border.all(color: btnBordercolor)),
        child: Stack(
          children: [
            Visibility(
              visible: isLoading ? false : true,
              child: Center(
                  child: PrimaryText(
                text: buttonName,
                color: btntrxtcolor,
                size: btnTextSize ?? 16,
              )),
            ),
            Visibility(
              visible: isLoading,
              child: Center(
                child: Loader(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
