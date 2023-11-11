import 'package:fitfutures/model/user_info.dart';
import 'package:flutter/material.dart';

class UserDataNotifier extends ChangeNotifier {
  UserInfo userInfo = UserInfo(id: 0);

  int? get id => userInfo.id;

  void addJWT(UserInfo userRes) {
    print(userRes.id);
    userInfo = userRes;
  }
}
