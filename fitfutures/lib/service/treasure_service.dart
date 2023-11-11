import 'package:dio/dio.dart';
import 'package:fitfutures/model/token.dart';
import 'package:fitfutures/model/treasure.dart';
import 'package:fitfutures/service/base/base_entity_service.dart';

class TreasureService extends BaseEntityService<Treasure> {
  TreasureService()
      : super(
          url: "treasures",
          fromJsonFunction: (json) => Treasure.fromJson(json),
        );
}
