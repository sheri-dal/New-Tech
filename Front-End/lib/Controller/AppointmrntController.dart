import 'dart:async';

import 'package:cancerrapp/Helper/Services/BaseController.dart';
import 'package:cancerrapp/Models/AppoinmentModel.dart';
import 'package:cancerrapp/Models/DoctorModel.dart';
import 'package:cancerrapp/Repositories/AppoinrmentRepository.dart';
import 'package:cancerrapp/Repositories/DoctorRepository.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Helper/Components/SharePrefrencesKey.dart';
import '../Helper/Services/NotificationService.dart';

class AppointmentController extends BaseController {
  Future<List<DoctorModel>> GetAllDoctors() async {
    await Future.delayed(Duration(seconds: 2));
    var data = await DoctorRepository.dao.getAll();
    return data;
  }

  Future<bool> SaveAppoinment(int doctorId, DateTime? date) async {
    AppoinmentModel model = AppoinmentModel();

    if (date == null) {
      date = DateTime.now().add(Duration(days: 1));
    }

    SharedPreferences preferences = await SharedPreferences.getInstance();
    int userId = preferences.getInt(Prefkey.userId) as int;
    model.date = date;
    model.doctorId = doctorId;
    model.userId = userId;
    try {
      await AppoinementRepository.dao.insert(model);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> SendAppoinmentNotification() async {
    var appoinments = await AppoinementRepository.dao.getAll();
    var now = DateTime.now();
    var d1 = DateTime.utc(now.year, now.month, now.day);
    for (var appoinment in appoinments) {
      if (appoinment.date != null) {
        if (appoinment.date?.compareTo(d1) == 0) {
          print('true');
        } else {
          if (appoinment.date != null) {
            var formattedDate = DateFormat.yMMMMd().format(appoinment.date!);
            NotificationService ns = NotificationService();
            ns.sendNotification("Appoinment Reminder",
                "Your Appoinment Date is $formattedDate");
          }
        }
      }
    }
  }
}
