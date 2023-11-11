import 'package:fitfutures/model/base/a_base_entity.dart';

class Treasure extends BaseEntity {
  String name;
  double cordx;
  double cordy;

  Treasure({
    required int id,
    required this.name,
    required this.cordx,
    required this.cordy,
  }) : super(id: id);

  factory Treasure.fromJson(Map<String, dynamic> json) {
    return Treasure(
      id: json['id'],
      name: json['name'],
      cordx: json["coord_x"],
      cordy: json["coord_y"],
    );
  }
}
