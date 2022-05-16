import 'dart:async';
import 'package:get/get.dart';
import 'package:poll_dashboard/app/data/local/auth_local_data_source.dart';
import 'package:poll_dashboard/app/routes/app_pages.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Timer.periodic(const Duration(seconds: 2), (timer) {
      Get.offAllNamed(
          AuthLocaleDataSource.isLoggedIn() ? Routes.HOME : Routes.LOGIN);
      timer.cancel();
    });
  }
}
