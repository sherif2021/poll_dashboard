import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poll_dashboard/app/data/local/auth_local_data_source.dart';
import 'package:poll_dashboard/app/data/remote/auth_remote_data_source.dart';
import 'package:poll_dashboard/app/routes/app_pages.dart';

class LoginController extends GetxController {
  final _isLoading = Rx(false);
  final _isUsernameError = Rx(false);
  final _isPasswordError = Rx(false);

  bool get isLoading => _isLoading.value;

  bool get isUsernameError => _isUsernameError.value;

  bool get isPasswordError => _isPasswordError.value;

  String? username, password;

  void login() async {
    _isUsernameError.value = username == null || username!.length < 3;
    _isPasswordError.value = password == null || password!.length < 3;

    if (!isUsernameError && !isPasswordError) {
      _isLoading.value = true;
      try {
        final token = await AuthRemoteDataSource.login(username!, password!);
        await AuthLocaleDataSource.saveToken(token);
        Get.offAllNamed(Routes.HOME);
      } catch (e) {
        Get.snackbar('Error'.tr, e.toString().replaceAll('Exception', ''),
            duration: const Duration(
              seconds: 5,
            ),
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red);
      }
      _isLoading.value = false;
    }
  }
}
