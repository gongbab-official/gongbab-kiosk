import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:injectable/injectable.dart';
import 'package:gongbab/data/network/rest_api_client.dart';
import 'package:gongbab/config/api_config.dart'; // Import the api_config.dart

@singleton
class AppApiClient extends RestApiClient {
  AppApiClient() : super(dio: Dio()) {
    dio.options.baseUrl = baseUrl; // Use the baseUrl from api_config.dart
    dio.options.connectTimeout = const Duration(seconds: 5);
    dio.options.receiveTimeout = const Duration(seconds: 3);
    dio.options.contentType = 'application/json';
    dio.options.headers = {
      'Accept': 'application/json',
    };

    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90,
    ));
  }
}
