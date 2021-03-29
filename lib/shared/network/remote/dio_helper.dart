import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

abstract class DioHelper {
  Future<Response> postData({
    @required String path,
    @required dynamic data,
    String query,
    String token,
  });

  Future<Response> getData({
    @required String path,
    dynamic query,
    String token,
  });
}

class DioImplementation extends DioHelper
{
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://student.valuxapps.com/api/',
      receiveDataWhenStatusError: true,
    ),
  );

  @override
  Future<Response> postData({
    String path,
    dynamic data,
    String query,
    String token,
  }) async {
    dio.options.headers = {
      'lang': 'en',
      'Content-Type': 'application/json',
      'Authorization': token ?? '',
    };

    return await dio.post(
      path,
      data: data,
    );
  }

  @override
  Future<Response> getData({
    String path,
    dynamic query,
    String token,
  }) async {
    dio.options.headers = {
      'lang': 'en',
      'Content-Type': 'application/json',
      'Authorization': token ?? '',
    };

    return await dio.get(
      path,
      queryParameters: query,
    );
  }
}
// class DioHelper {
//   static Dio dio;
//
//   DioHelper() {
//     dio = Dio(
//       BaseOptions(
//         baseUrl: 'https://student.valuxapps.com/api/',
//         headers:
//         {
//           'lang':'en',
//           'Content-Type': 'application/json',
//         },
//       ),
//     );
//   }
//
//   static Future<Response> postData({
//     path,
//     data,
//     token,
//     query,
//   }) async
//   {
//     if (token != null) {
//       dio.options.headers = {
//         'Authorization': token?? '',
//       };
//     }
//
//     return await dio.post(
//       path,
//       data: data ?? null,
//       queryParameters: query ?? null,
//     );
//   }
//   static Future<Response> getData({
//     String path,
//     dynamic query,
//     String token,
//   }) async {
//     dio.options.headers = {
//       'lang': 'en',
//       'Content-Type': 'application/json',
//       'Authorization': token ?? '',
//     };
//
//     return await dio.get(
//       path,
//       queryParameters: query,
//     );
//   }
// }

