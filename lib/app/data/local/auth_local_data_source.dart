import 'package:get_storage/get_storage.dart';

class AuthLocaleDataSource {
  static Future<void> saveToken(String token) async {
    await GetStorage().write('token', token);
  }

  static String getToken() {
    return GetStorage().read('token');
  }

  static bool isLoggedIn() {
    return GetStorage().hasData('token');
  }
}
