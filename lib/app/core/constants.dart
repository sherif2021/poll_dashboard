import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

final dio = Dio(
  BaseOptions(
      baseUrl:
          // 'http://gala.ajory.online:5555/api',

          'http://192.168.1.6:5555/api',
      headers: {
        'language': GetStorage().read('language') ?? 'en',
      }),
);
