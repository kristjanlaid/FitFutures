import 'package:dio/dio.dart';
import 'package:fitfutures/service/base/dio.dart';

class BaseService {
  final Dio client = DioSingleton.dio;
  late String baseUrl;

  BaseService({required url}) {
    baseUrl = "https://fitfutures-api.vercel.app/$url";
  }
}
