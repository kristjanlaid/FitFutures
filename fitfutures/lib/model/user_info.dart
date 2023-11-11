import 'package:fitfutures/model/base/a_base_entity.dart';

class UserInfo extends BaseEntity {
  UserInfo({
    required int id,
  }) : super(id: id);

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      id: json['id'],
    );
  }
}
