import 'package:cancerrapp/Helper/Services/BaseController.dart';
import 'package:cancerrapp/Models/AppoinmentModel.dart';
import 'package:cancerrapp/Models/DoctorModel.dart';
import 'package:cancerrapp/Repositories/AppoinrmentRepository.dart';
import 'package:cancerrapp/Repositories/DoctorRepository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Helper/Components/SharePrefrencesKey.dart';

class AppointmentController extends BaseController {
  Future<List<DoctorModel>> GetAllDoctors() async {
    await Future.delayed(Duration(seconds: 2));
    var data = await DoctorRepository.dao.getAll();
    return data;
  }

  Future<bool> SaveAppoinment(int doctorId, DateTime? date) async {
    AppoinmentModel model = AppoinmentModel();

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
}
