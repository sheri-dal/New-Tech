import 'package:cancerrapp/Helper/Components/dialog_helper.dart';
import 'package:cancerrapp/Helper/Helper.dart';
import 'package:cancerrapp/Models/UserModel.dart';
import 'package:cancerrapp/Repositories/UserRepository.dart';
import 'package:cancerrapp/View/DashBoard.dart';
import 'package:cancerrapp/View/Login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Helper/Components/Animation.dart';
import '../Helper/Components/SharePrefrencesKey.dart';
import '../Helper/Services/BaseController.dart';

class UserController extends BaseController {
  Future<void> SignUp(UserModel userModel, BuildContext context) async {
    if (userModel.email == null || userModel.email == "") {
      DialogHelper.showErroDialog(description: "Email Required");
    } else if (!Helper.isEmailValid(userModel.email!)) {
      DialogHelper.showErroDialog(description: "Email is badly formatted");
    } else if (userModel.userName == null || userModel.userName == "") {
      DialogHelper.showErroDialog(description: "UserName Required");
    } else if (userModel.password == null || userModel.password == "") {
      DialogHelper.showErroDialog(description: "Password Required");
    } else {
      var user = await UserRepository.getUser(userModel.userName!);
      if (user != null) {
        DialogHelper.showErroDialog(description: "UserName Already Exist");
      } else {
        userModel.password = Helper.PasswordHash(userModel.password!);
        await UserRepository.dao.insert(userModel);
        Navigator.push(context, scaleIn(LogInView()));
      }
    }
  }

  Future<void> Login(
      String userName, String password, BuildContext context) async {
    password = Helper.PasswordHash(password);
    var data = await UserRepository.LogIn(userName, password);
    if (data == null) {
      DialogHelper.showErroDialog(description: "User not found");
    } else {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt(Prefkey.userId, data.id ?? 0);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => DashboardView(),
          ),
          (r) => false);
    }
  }
}
