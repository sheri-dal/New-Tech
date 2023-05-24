import 'dart:async';

import 'package:cancerrapp/Controller/AppointmrntController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workmanager/workmanager.dart';
import 'Helper/Services/NotificationService.dart';
import 'View/Splash.dart';
// import 'package:sqflite/sqflite.dart';

Future<void> main() async {
  await WidgetsFlutterBinding.ensureInitialized();

  NotificationService ns = NotificationService();
  ns.initiliazeNotification();

  await Workmanager().initialize(
    callBackDispacture,
    // isInDebugMode: true,
  );

  Timer.periodic(Duration(seconds: 15), (Timer t) async {
    AppointmentController appointmentController =
        Get.put(AppointmentController());

    appointmentController.SendAppoinmentNotification();
    // await Workmanager().initialize(
    // callBackDispacture,
    // isInDebugMode: true,
    // );
  });
  var uniqueId = DateTime.now().second.toString();

  await Workmanager().registerPeriodicTask(uniqueId, "firstTask",
      frequency: Duration(seconds: 15),
      initialDelay: Duration(seconds: 5),
      // existingWorkPolicy: ExistingWorkPolicy.replace,
      backoffPolicyDelay: Duration(seconds: 15),
      constraints: Constraints(
        networkType: NetworkType.connected,
      ));

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

const taskName = "firstTask";
Future<void> callBackDispacture() async {
  Workmanager().executeTask((taskName, inputData) async {
    AppointmentController appointmentController =
        Get.put(AppointmentController());

    appointmentController.SendAppoinmentNotification();

    return Future(() => true);
  });
}
