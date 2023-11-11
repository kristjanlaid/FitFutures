import 'package:dio/dio.dart';
import 'package:fitfutures/model/regsiter_data.dart';
import 'package:fitfutures/model/user_info.dart';
import 'package:fitfutures/service/base/base_service.dart';
import 'package:fitfutures/service/base/dio.dart';

class AuthService extends BaseService {
  AuthService() : super(url: "users");

  Future<UserInfo> register({required RegisterData registerData}) async {
    Response res =
        await client.post("$baseUrl/register", data: registerData.toJson());
    UserInfo jwt = UserInfo.fromJson(res.data);
    return jwt;
  }
}
