import 'package:fitfutures/model/complete_treasure.dart';
import 'package:fitfutures/model/token.dart';
import 'package:fitfutures/model/treasure.dart';
import 'package:fitfutures/service/auth/auth_service.dart';
import 'package:fitfutures/service/treasure_service.dart';
import 'package:flutter/material.dart';

class TradeScreen extends StatefulWidget {
  const TradeScreen({super.key});

  @override
  State<TradeScreen> createState() => _TradeScreenState();
}

class _TradeScreenState extends State<TradeScreen> {
  late Future<List<Treasure>> treasures;
  UserService service = UserService();

  Token? token;

  void pressButton() async {
    CompleteTreasure completeTreasure =
        CompleteTreasure(userId: 2, treasureId: 97);
    Token newToken = await service.completeTreasure(completeTreasure);

    setState(() {
      token = newToken;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextButton(onPressed: pressButton, child: Text("Press me")),
        (token != null ? Image.memory(token!.pictureBytes) : Text("data"))
      ],
    );
  }
}
