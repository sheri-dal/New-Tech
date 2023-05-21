import 'dart:io';

import 'package:cancerrapp/Controller/ReportController.dart';
import 'package:cancerrapp/Helper/Components/PrimaryText.dart';
import 'package:cancerrapp/Helper/Widgets/MyButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class GeneratrReuslt extends StatefulWidget {
  const GeneratrReuslt({super.key});

  @override
  State<GeneratrReuslt> createState() => _GeneratrReusltState();
}

class _GeneratrReusltState extends State<GeneratrReuslt> {
  ReporoController reporoController = Get.put(ReporoController());
  File? imageFile;
  Future<void> getImage({required ImageSource source}) async {
    final file = await ImagePicker().pickImage(
      source: source,
    );

    if (file?.path != null) {
      setState(() {
        imageFile = File(file?.path ?? "");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: PrimaryText(
          text: "Generate Result",
          size: 25,
          color: Colors.white,
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            height: 600,
            width: MediaQuery.of(context).size.width * .8,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              border: Border.all(color: Colors.lightBlue.shade100, width: 2),
            ),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // crossAxisAlignment: CrossAxisAlignment.,
              children: [
                SizedBox(height: 50),
                PrimaryText(text: "Upload"),
                // SizedBox(height: 20),
                MyButton(
                  bthWidth: 150,
                  buttonName: "Camera",
                  onPressed: () {
                    getImage(source: ImageSource.camera);
                  },
                  btnborder: BorderRadius.zero,
                  btnColor: Colors.transparent,
                  btntrxtcolor: Colors.black,
                  btnBordercolor: Colors.lightBlue.shade100,
                ),
                // SizedBox(height: 20),
                MyButton(
                  bthWidth: 150,
                  buttonName: "Gallery",
                  btntrxtcolor: Colors.black,
                  btnborder: BorderRadius.zero,
                  onPressed: () {
                    getImage(source: ImageSource.gallery);
                  },
                  btnColor: Colors.transparent,
                  btnBordercolor: Colors.lightBlue.shade100,
                ),
                SizedBox(height: 30),
                imageFile == null
                    ? Icon(
                        Icons.camera_alt,
                        size: MediaQuery.of(context).size.width * .7,
                      )
                    : Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * .5,
                            height: 150,
                            child: Image.file(imageFile!),
                          ),
                          SizedBox(height: 20),
                          MyButton(
                            bthWidth: 150,
                            buttonName: "Generate Result",
                            onPressed: () async {
                              await reporoController.Upload(
                                  imageFile!, context);
                            },
                            btnborder: BorderRadius.zero,
                            btnColor: Colors.transparent,
                            btntrxtcolor: Colors.black,
                            btnBordercolor: Colors.lightBlue.shade100,
                          ),
                        ],
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Widget CaptureImage() {
//   return AlertDialog(
//     title: PrimaryText(text: "Generate Result"),
//     content: PrimaryText(
//       text: "Upload",
//       size: 15,
//     ),
//     actions: <Widget>[
//       MyButton(
//         buttonName: "Camera",
//         onPressed: () {},
//       ),
//       MyButton(
//         buttonName: "Galery",
//         onPressed: () {},
//       ),
//       MyButton(
//         bthWidth: 120,
//         buttonName: "Close",
//         btnColor: Colors.lightBlue,
//         onPressed: () {
//           Get.back();
//         },
//       )
//     ],
//   );
// }
