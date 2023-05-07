import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Widgets/Loader.dart';
import '../Widgets/MyButton.dart';
import 'PrimaryText.dart';

class DialogHelper {
  //show error dialog
  static void showErroDialog(
      {String title = 'Error', String? description = 'Something went wrong'}) {
    Get.dialog(
      Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              PrimaryText(text: title),
              PrimaryText(
                text: description ?? "",
                size: 15,
              ),
              SizedBox(
                height: 15,
              ),
              MyButton(
                buttonName: "Okay",
                onPressed: () {
                  if (Get.isDialogOpen!) Get.back();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  static void showLoading([String? message]) {
    Get.dialog(
      Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Loader(),
              SizedBox(height: 8),
              Text(message ?? 'Loading...'),
            ],
          ),
        ),
      ),
    );
  }

  static void hideLoading() {
    if (Get.isDialogOpen!) {
      Get.back();
    }
  }
}
