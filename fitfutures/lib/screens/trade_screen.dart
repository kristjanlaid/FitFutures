import 'package:fitfutures/consts/app_colors.dart';
import 'package:fitfutures/model/user_collection.dart';
import 'package:fitfutures/model/user_data_notifier.dart';
import 'package:fitfutures/service/auth/auth_service.dart';
import 'package:fitfutures/widgets/collection_card.dart';
import 'package:fitfutures/widgets/daily_chest_progress.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TradeScreen extends StatefulWidget {
  const TradeScreen({super.key});

  @override
  State<TradeScreen> createState() => _TradeScreenState();
}

class _TradeScreenState extends State<TradeScreen> {
  UserService service = UserService();
  late Future<List<UserCollection>> userCollections;
  late int userId;
  late Future<int> chestCount;

  Future<List<UserCollection>> fetchUserCollections() {
    return service.getUserCollections(userId);
  }

  Future<int> fetchChestsOpened() {
    return service.getTreasuresOpenedToday(userId);
  }

  @override
  void initState() {
    super.initState();
    userId = Provider.of<UserDataNotifier>(context, listen: false).id!;

    userCollections = fetchUserCollections();
    chestCount = fetchChestsOpened();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "fitfutures",
            style: TextStyle(
                color: AppColors.primary1,
                fontWeight: FontWeight.bold,
                fontSize: 16),
          ),
          const Text(
            "YOUR COLLECTIONS",
            style: TextStyle(color: Colors.black87, fontSize: 24),
          ),
          Expanded(
            child: FutureBuilder<List<UserCollection>>(
              future: userCollections,
              builder: (context, snapshot) {
                return ListView.builder(
                  itemCount: snapshot.data != null ? snapshot.data!.length : 0,
                  padding: const EdgeInsets.only(top: 12),
                  itemBuilder: (context, index) {
                    return CollectionCard(
                        userCollection: snapshot.data![index]);
                  },
                );
              },
            ),
          ),
          const Text(
            "DAILY TREASURES",
            style: TextStyle(color: Colors.black87, fontSize: 24),
          ),
          const Padding(padding: EdgeInsets.only(bottom: 10)),
          DashedProgressBar(currentStep: chestCount)
        ],
      ),
    );
  }
}
