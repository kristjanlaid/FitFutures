import 'package:dio/dio.dart';
import 'package:fitfutures/model/complete_treasure.dart';
import 'package:fitfutures/model/regsiter_data.dart';
import 'package:fitfutures/model/token.dart';
import 'package:fitfutures/model/user_collection.dart';
import 'package:fitfutures/model/user_info.dart';
import 'package:fitfutures/service/base/base_service.dart';
import 'package:fitfutures/service/base/dio.dart';

class UserService extends BaseService {
  UserService() : super(url: "users");

  Future<UserInfo> register({required RegisterData registerData}) async {
    Response res =
        await client.post("$baseUrl/register", data: registerData.toJson());
    UserInfo jwt = UserInfo.fromJson(res.data);
    return jwt;
  }

  Future<Token> completeTreasure(CompleteTreasure treasureDto) async {
    Response res =
        await client.post("$baseUrl/complete", data: treasureDto.toJson());
    return Token.fromJson(res.data);
  }

  Future<int> getTreasuresOpenedToday(int id) async {
    Response res = await client.get("$baseUrl/treasures/$id");
    return int.parse(res.data.toString());
  }

  Future<List<UserCollection>> getUserCollections(int userId) async {
    Response res = await client.get("$baseUrl/collections/$userId");
    final List<Map<String, dynamic>> dataList =
        List<Map<String, dynamic>>.from(res.data);
    final List<UserCollection> entities =
        dataList.map((jsonData) => UserCollection.fromJson(jsonData)).toList();
    return entities;
  }
}
