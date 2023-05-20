import 'dart:async';

import 'package:cancerrapp/Helper/Widgets/Loader.dart';
import 'package:flutter/material.dart';

import '../Helper/Components/ImagesPath.dart';
import 'Login.dart';

class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  startTime() {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    // Navigator.push(context, scaleIn(LogInView()));
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => LogInView(),
        ),
        (r) => false);
  }

  @override
  void initState() {
    super.initState();

    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.centerLeft,
            colors: [
              Colors.blue.shade100,
              // Colors.lightBlue,
              Colors.black12,
            ],
          ),
        ),
        child: Column(
          children: [
            Image.asset(AppImages.Logo, height: 200),
            Loader(
              loadingText: "Cancer App",
              backgroundColor: Colors.lightBlue,
              txtColor: Colors.white,
              txtsize: 25,
            ),
          ],
        ),
      ),
    );
  }
}
