import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiClient {
  static const bool isDebug = false;
  static final ApiClient _singleton = ApiClient._internal();
  //var auth = 'Basic ${base64Encode(utf8.encode('proanimatie:j&WbOzYrC-8b'))}';
  Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://firebasestorage.googleapis.com',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ),
  );

  ApiClient._internal() {
    initApiClient();
  }

  factory ApiClient() => _singleton;

  static ApiClient get shared => _singleton;

  Future<String> refreshToken() async {
    return 'your_new_access_token';
  }

  void initApiClient() async {
    if (isDebug) {
      dio.interceptors.add(PrettyDioLogger(
        request: isDebug,
        requestHeader: isDebug,
        requestBody: isDebug,
        responseBody: isDebug,
        responseHeader: isDebug,
        error: isDebug,
        compact: isDebug,
      ));
    }
    // dio.interceptors.add(InterceptorsWrapper(
    //   onRequest: (options, handler) async {
    //     String token = await SessionManager.getAccessToken();
    //     //if(token.isNotEmpty) {
    //     options.headers.putIfAbsent('Authorization',
    //             () => 'Bearer $token');
    //     // }else {
    //     //   options.headers.putIfAbsent('authorization',
    //     //         () => auth);
    //     // }
    //     return handler.next(options);
    //   },
    //   onError: (DioException e, handler) async {
    //     return handler.next(e);
    //   },
    // ),);


  }

  static Dio createSimpleDio() {
    Dio dio = Dio();
    return dio;
  }


  _parseAndDecode(String response) {
    return jsonDecode(response);
  }

  parseJson(String text) {
    return compute(_parseAndDecode, text);
  }
}