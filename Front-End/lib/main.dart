import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'Helper/Services/NotificationService.dart';
import 'View/Splash.dart';
// import 'package:sqflite/sqflite.dart';

Future<void> main() async {
  await WidgetsFlutterBinding.ensureInitialized();

  NotificationService ns = NotificationService();
  ns.initiliazeNotification();
  ns.sendNotification("hello", "Hello Wordl");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Skin Caner',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashView(),
    );
  }
}
