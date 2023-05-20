import 'package:cancerrapp/Helper/Widgets/MyButton.dart';
import 'package:cancerrapp/Helper/Widgets/MyTextField.dart';
import 'package:cancerrapp/Models/UserModel.dart';
import 'package:cancerrapp/View/Login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controller/UserController.dart';
import '../Helper/Components/Animation.dart';
import '../Helper/Components/ImagesPath.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController userNameController = TextEditingController();
    TextEditingController firstNameController = TextEditingController();
    TextEditingController lastNameController = TextEditingController();
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
                      Navigator.push(context, scaleIn(LogInView()));
                    },
                    btnborder: BorderRadius.circular(5),
                  )),
              SizedBox(
                height: 100,
              ),
              Image.asset(AppImages.Logo, height: 200),
              MyTextField(
                controller: userNameController,
                labelText: "UserName",
                validator: (value) {
                  return null;

                  // if(!Genera)
                },
              ),
              MyTextField(
                controller: passwordController,
                labelText: "Password",
                obscuretext: true,
              ),
              MyTextField(
                controller: emailController,
                labelText: "Email",
                validator: (value) {
                  return null;

                  // if(!Genera)
                },
              ),
              MyTextField(
                controller: firstNameController,
                labelText: "FirstName",
                validator: (value) {
                  return null;

                  // if(!Genera)
                },
              ),
              MyTextField(
                controller: lastNameController,
                labelText: "LastName",
                validator: (value) {
                  return null;

                  // if(!Genera)
                },
              ),
              SizedBox(
                height: 50,
              ),
              MyButton(
                buttonName: "SignIn",
                onPressed: () async {
                  UserModel model = UserModel();
                  model.email = emailController.text;
                  model.password = passwordController.text;
                  model.userName = userNameController.text;
                  model.firstName = firstNameController.text;
                  model.lastName = lastNameController.text;
                  await userController.SignUp(model, context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
