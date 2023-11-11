import 'package:dio/dio.dart';
import 'package:fitfutures/model/base/a_base_entity.dart';
import 'package:fitfutures/service/base/base_service.dart';

class BaseEntityService<T extends BaseEntity> extends BaseService {
  final T Function(Map<String, dynamic> json) fromJsonFunction;

  BaseEntityService({
    required String url,
    required this.fromJsonFunction,
  }) : super(url: url);

  Future<List<T>> getAll() async {
    Response res = await client.get(baseUrl);
    print(res.statusCode);
    final List<Map<String, dynamic>> dataList =
        List<Map<String, dynamic>>.from(res.data);
    final List<T> entities =
        dataList.map((jsonData) => fromJsonFunction(jsonData)).toList();
    return entities;
  }

  void delete(String id) async {
    await client.delete("$baseUrl/$id");
  }

  Future<T> getById(String id) async {
    Response res = await client.get("$baseUrl/$id");
    return fromJsonFunction(res.data);
  }

  Future<T> update(T entity) async {
    Response res = await client.put(baseUrl, data: entity);
    return fromJsonFunction(res.data);
  }

  Future<T> create(T entity) async {
    Response res = await client.post(baseUrl, data: entity);
    return fromJsonFunction(res.data);
  }
}
