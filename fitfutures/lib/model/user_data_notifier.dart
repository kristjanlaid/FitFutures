import 'package:fitfutures/model/user_info.dart';
import 'package:flutter/material.dart';

class UserDataNotifier extends ChangeNotifier {
  UserInfo userInfo = UserInfo(id: 2);

  int? get id => userInfo.id;

  void addJWT(UserInfo userRes) {
    userInfo = userRes;
  }
}
