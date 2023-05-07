import 'package:cancerrapp/Controller/UserController.dart';
import 'package:cancerrapp/Helper/Widgets/MyButton.dart';
import 'package:cancerrapp/Helper/Widgets/MyTextField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Helper/Components/Animation.dart';
import 'SignUp.dart';

class LogInView extends StatelessWidget {
  const LogInView({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController userNameController = TextEditingController();
    TextEditingController PasswordController = TextEditingController();
    UserController userController = Get.put(UserController());
    return SafeArea(
      child: Scaffold(
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
          child: ListView(
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  margin: EdgeInsets.only(left: 300, top: 20, right: 10),
                  width: 90,
                  child: MyButton(
                    btnColor: Colors.blue,
                    bthHeight: 30,
                    buttonName: "SignUp",
                    margin: EdgeInsets.zero,
                    onPressed: () {
                      Navigator.push(context, scaleIn(SignUpView()));
                    },
                    btnborder: BorderRadius.circular(5),
                  )),
              SizedBox(
                height: 100,
              ),
              FlutterLogo(size: 80),
              MyTextField(
                controller: userNameController,
                labelText: "UserName",
                validator: (value) {
                  return null;

                  // if(!Genera)
                },
              ),
              MyTextField(
                controller: PasswordController,
                labelText: "Password",
                obscuretext: true,
              ),
              SizedBox(
                height: 50,
              ),
              MyButton(
                buttonName: "SignIn",
                onPressed: () async {
                  // await Helper.deleteDatabase();
                  userController.Login(userNameController.text,
                      PasswordController.text, context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
