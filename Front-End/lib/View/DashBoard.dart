import 'package:cancerrapp/Helper/Components/ImagesPath.dart';
import 'package:cancerrapp/Helper/Components/PrimaryText.dart';
import 'package:cancerrapp/View/Login.dart';
import 'package:flutter/material.dart';

import '../Helper/ClipPath.dart';
import '../Helper/Components/Animation.dart';
import 'Appoinment.dart';
import 'GeneratrReuslt.dart';
import 'Report.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  @override
  Widget build(BuildContext context) {
    // MaterialPageRoute route = MaterialPageRoute(
    //   builder: (context) => scaleIn(LogInView()),
    // );
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              ClipPath(
                clipper: Customshape(),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * .35,
                  // margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(color: Colors.lightBlue.shade100),
                  child: Column(
                    children: [
                      // SizedBox(height: 10),
                      Image.asset(AppImages.Logo, height: 130),
                      PrimaryText(
                        text: "Home Screen",
                        size: 20,
                        color: Colors.blue,
                      ),
                      SizedBox(height: 5),
                      PrimaryText(
                        text: "Welcome to your medical app",
                        size: 15,
                        color: Colors.white,
                      ),
                      PrimaryText(
                        text: "detecting cancer app",
                        size: 15,
                        color: Colors.white,
                      ),
                      ClipPath(
                        clipper: CustomClipperLine(),
                        child: Container(
                          color: Colors.lightBlue.shade200,
                          height: MediaQuery.of(context).size.height * .1,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PrimaryText(text: "Our Health Feature"),
                    IconButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LogInView(),
                            ),
                            (r) => false);
                      },
                      icon: Icon(Icons.login),
                    )
                  ],
                ),
              ),
              SizedBox(height: 15),
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                children: [
                  IconsAndText(
                    AppImages.camera,
                    "Capture Image",
                    () {
                      Navigator.push(context, scaleIn(GeneratrReuslt()));
                    },
                  ),
                  IconsAndText(
                    AppImages.patietntReport,
                    "Patietnt Reports",
                    () {
                      Navigator.push(context, scaleIn(ReportView()));
                    },
                  ),
                  IconsAndText(
                    AppImages.healthTip,
                    "Health & Tips",
                    () {
                      print("Health & Tips");
                    },
                  ),
                  IconsAndText(
                    AppImages.doctorAppoinment,
                    "Book An Appoinment",
                    () {
                      Navigator.push(context, scaleIn(AppoinmentView()));

                      print("Book An Appoinment");
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget IconsAndText(String imageText, String text, void Function()? ontap) {
    return InkWell(
      onTap: ontap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            imageText,
            height: 80,
          ),
          PrimaryText(
            text: text,
            textAllign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
