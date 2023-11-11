import 'package:fitfutures/model/treasure.dart';
import 'package:fitfutures/service/treasure_service.dart';
import 'package:flutter/material.dart';

class TradeScreen extends StatefulWidget {
  const TradeScreen({super.key});

  @override
  State<TradeScreen> createState() => _TradeScreenState();
}

class _TradeScreenState extends State<TradeScreen> {
  late Future<List<Treasure>> treasures;
  TreasureService service = TreasureService();

  Future<List<Treasure>> fetchTreasures() async {
    return await service.getAll();
  }

  @override
  void initState() {
    super.initState();
    treasures = fetchTreasures();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: FutureBuilder<List<Treasure>>(
            future: treasures,
            builder: (context, snapshot) {
              return ListView.builder(
                itemCount: snapshot.data != null ? snapshot.data!.length : 0,
                padding: const EdgeInsets.only(top: 12),
                itemBuilder: (context, index) {
                  return Text(snapshot.data![index].name);
                },
              );
            },
          ),
        )
      ],
    );
  }
}
