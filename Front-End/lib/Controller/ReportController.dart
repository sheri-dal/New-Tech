import 'dart:convert';
import 'dart:io';

import 'package:cancerrapp/Helper/Components/dialog_helper.dart';
import 'package:cancerrapp/Helper/Services/BaseController.dart';
import 'package:cancerrapp/Models/ReportsModel.dart';
import 'package:cancerrapp/Repositories/ReportRepositort.dart';
import 'package:cancerrapp/View/Appoinment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Helper/Components/Animation.dart';
import '../Helper/Components/PrimaryText.dart';
import '../Helper/Components/SharePrefrencesKey.dart';
import '../Helper/Widgets/MyButton.dart';

class ReporoController extends BaseController {
  Future<List<ReportModel>> GetAllReport() async {
    var reports = await ReportsRepositort().getAllByUser();
    return reports;
  }

  // Future<void> SendFile() async {
  //   http.post(
  //     url,
  //   );
  // }

  // Future<void> SendFile(File image) async {
  //   try {
  //     var url = await Uri.parse("http://192.168.0.100:8080/predict");
  //     // var bytes = image.readAsBytesSync();
  //     var header = {
  //       'Content-Type': 'multipart/form-data',
  //       //   "X-Requested-With": "XMLHttpRequest",
  //       'ENCTYPE': 'multipart/form-data'
  //     };
  //     var res =
  //         'data:image/png;base64,' + base64Encode(image.readAsBytesSync());

  //     var map = new Map<String, dynamic>();
  //     map['file'] = res;

  //     var response = await http.post(
  //       url,
  //       headers: header,
  //       body: map,
  //       encoding: Encoding.getByName("utf-8"),
  //     );

  //     // print(response.body);

  //     print(response.statusCode);
  //   } catch (ex) {
  //     throw ex;
  //   }
  // }

  // postData(File image) async {
  //   var url = "http://192.168.0.100:8080/predict";
  //   var bytes = image.readAsBytesSync();
  //   var body = {"file": bytes};
  //   // var body = await MultipartFile.fromFile(image.path);
  //   var dio = Dio();
  //   try {
  //     // FormData formData = new FormData.fromMap(body);
  //     Response response = await dio.post(url, data: body);
  //     return response.data;
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  Upload(File imageFile, BuildContext context) async {
    showLoading();
    var uploadURL = "http://192.168.0.101:8080/predict";
    var stream =
        // ignore: deprecated_member_use
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();

    var uri = Uri.parse(uploadURL);

    var request = new http.MultipartRequest("POST", uri);
    var multipartFile = new http.MultipartFile('file', stream, length,
        filename: basename(imageFile.path));
    //contentType: new MediaType('image', 'png'));

    request.files.add(multipartFile);
    var response = await request.send();
    print(response.statusCode);
    if (response.statusCode == 200) {
      response.stream.transform(utf8.decoder).listen((value) async {
        var decode = jsonDecode(value);
        var classs = decode["class"];
        var confidence = decode["confidence"];
        print("percentage: $confidence ,  classs : $classs");

        var pref = await SharedPreferences.getInstance();
        var userId = pref.getInt(Prefkey.userId);

        if (classs == "Skin") {
          var reposrt = ReportModel(
            reportDateTime: DateTime.now(),
            userId: userId,
            cancerStage: "NOT FOUND",
          );
          await ReportsRepositort.dao.insert(reposrt);
          Get.dialog(
            NotFound(context, confidence),
            barrierDismissible: false,
          );
        } else if (classs == "Nevus Stage 1") {
          var reposrt = ReportModel(
            reportDateTime: DateTime.now(),
            userId: userId,
            cancerStage: "Nevus Found with $confidence%",
          );
          await ReportsRepositort.dao.insert(reposrt);
          Get.dialog(
            Found(context, confidence, classs),
            barrierDismissible: false,
          );
        } else if (classs == "Nevus Stage 2") {
          var reposrt = ReportModel(
            reportDateTime: DateTime.now(),
            userId: userId,
            cancerStage: "Nevus Found with $confidence%",
          );
          await ReportsRepositort.dao.insert(reposrt);
          Get.dialog(
            Found(context, confidence, classs),
            barrierDismissible: false,
          );
        } else if (classs == "Nevus Stage 3") {
          DialogHelper.showErroDialog(description: "Skin not found");
        } else if (classs == "Wrong object") {
          DialogHelper.showErroDialog(description: "Skin not found");
        }
      });
      hideLoading();
    } else {
      hideLoading();
      DialogHelper.showErroDialog(description: "Skin not found");
    }
  }
}

Widget Found(BuildContext context, confidence, classs) {
  return AlertDialog(
    title: PrimaryText(text: "Alert $classs"),
    content: PrimaryText(
        text: "Unfortunately $classs found with $confidence%", size: 18),
    actionsAlignment: MainAxisAlignment.start,
    actionsPadding: EdgeInsets.only(right: 40),
    actions: [
      PrimaryText(
        text: "Do you have appoinment of doctor",
        size: 15,
        textAllign: TextAlign.left,
      ),
      SizedBox(height: 10),
      Row(
        children: [
          Expanded(
            child: MyButton(
              bthWidth: 120,
              buttonName: "Yes",
              btnTextSize: 16,
              btnColor: Colors.lightBlue,
              onPressed: () async {
                Navigator.push(context, scaleIn(AppoinmentView()));
              },
            ),
          ),
          Expanded(
            child: MyButton(
              bthWidth: 120,
              buttonName: "No",
              btnColor: Colors.lightBlue,
              onPressed: () {
                Get.back();
              },
            ),
          ),
        ],
      )
    ],
  );
}

Widget NotFound(BuildContext context, confidence) {
  return AlertDialog(
    // title: PrimaryText(text: "Nevus Not found"),
    content: SingleChildScrollView(
      child: Column(
        children: [
          PrimaryText(
            text:
                "\u2022 Congratulations, The NEVUS hasn't been found but still, you need to take precautions to avoid it",
            textAllign: TextAlign.left,
            size: 20,
            fontWeight: FontWeight.w600,
          ),
          PrimaryText(
            text: "\u2022 Here are some nevus precautions:",
            textAllign: TextAlign.left,
            size: 18,
            fontWeight: FontWeight.w600,
          ),
          PrimaryText(
              text:
                  "\u2022 Protect skin from sun: Use sunscreen (SPF 30+) and wear protective clothing.",
              size: 15,
              fontWeight: FontWeight.w600,
              textAllign: TextAlign.left),
          PrimaryText(
            text:
                "\u2022 Regular skin checks: Monitor moles for changes in size, shape, color, or appearance. Consult a dermatologist if concerned.",
            textAllign: TextAlign.start,
            size: 15,
            fontWeight: FontWeight.w600,
          ),
          PrimaryText(
            text:
                "\u2022 Avoid tanning beds: Artificial UV radiation can increase the risk of developing nevi and skin cancer.",
            textAllign: TextAlign.left,
            size: 15,
            fontWeight: FontWeight.w600,
          ),
          PrimaryText(
            text:
                "\u2022 Practice self-examination: Regularly check your skin for new or changing moles and consult a dermatologist if any concerns arise.",
            textAllign: TextAlign.left,
            size: 15,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    ),
    actions: <Widget>[
      Expanded(
        child: MyButton(
          bthWidth: 120,
          buttonName: "Close",
          btnColor: Colors.lightBlue,
          onPressed: () {
            Get.back();
          },
        ),
      )
    ],
  );
}
