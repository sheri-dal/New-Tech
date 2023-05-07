import 'package:get/state_manager.dart';

import '../Components/dialog_helper.dart';

class BaseController extends GetxController {
  showLoading([String? message]) {
    DialogHelper.showLoading(message);
  }

  hideLoading() {
    DialogHelper.hideLoading();
  }
}
