import 'dart:typed_data';

import 'package:fitfutures/model/base/a_base_entity.dart';

class Token extends BaseEntity {
  String name;
  Uint8List pictureBytes;

  Token({
    required int id,
    required this.name,
    required this.pictureBytes,
  }) : super(id: id);

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      id: json['id'],
      name: json['name'],
      pictureBytes: Uint8List.fromList(List<int>.from(json["picture"]["data"])),
    );
  }
}
