import 'package:poll_dashboard/app/core/constants.dart';

class AuthRemoteDataSource {
  static Future<String> login(String username, String password) async {
    final result = await dio.post('/admin/login',
        data: {'username': username, 'password': password});
    if (result.data['status'] == false) {
      return throw Exception(result.data['message']);
    }
    return result.data['data'];
  }
}
