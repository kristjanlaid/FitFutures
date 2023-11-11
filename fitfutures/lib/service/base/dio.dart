import 'package:dio/dio.dart';

class DioSingleton {
  static Dio? _dio;

  // Private constructor to prevent direct instantiation
  DioSingleton._();

  static Dio get dio {
    _dio ??= Dio();
    return _dio!;
  }
}
