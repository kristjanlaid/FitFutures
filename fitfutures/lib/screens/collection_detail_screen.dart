import 'package:fitfutures/consts/app_colors.dart';
import 'package:fitfutures/model/token.dart';
import 'package:fitfutures/model/user_collection.dart';
import 'package:fitfutures/model/user_token.dart';
import 'package:fitfutures/widgets/collection_imges_scroll.dart';
import 'package:flutter/material.dart';

class CollectionDetailScreen extends StatelessWidget {
  const CollectionDetailScreen(
      {Key? key, required this.userCollection, required this.closeModal})
      : super(key: key);

  final UserCollection userCollection;

  final Function() closeModal;

  Map<Token, int> countTokenOccurrences(
      List<Token> allTokens, List<UserToken> tokenObjects) {
    Map<Token, int> result = {};

    for (var obj in tokenObjects) {
      int tokenId = obj.tokenId;
      Token theToken =
          allTokens.where((element) => element.id == tokenId).toList()[0];
      if (allTokens.any((token) => token.id == tokenId)) {
        result[theToken] = (result[theToken] ?? 0) + 1;
      }
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: EdgeInsets.all(24),
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
          TextButton.icon(
            onPressed: closeModal,
            style: const ButtonStyle(
                padding: MaterialStatePropertyAll(EdgeInsets.all(0))),
            icon: const Icon(
              Icons.arrow_back,
              color: AppColors.primary1,
            ),
            label: const Text(
              "Back",
              style: TextStyle(color: AppColors.primary1),
            ),
          ),
          Text(
            userCollection.name.toUpperCase(),
            style: TextStyle(color: Colors.black87, fontSize: 24),
          ),
          Text(
            userCollection.description,
            style: TextStyle(color: Colors.black87, fontSize: 12),
          ),
          Padding(padding: EdgeInsets.only(bottom: 10)),
          Center(child: Image.memory(userCollection.collectionPic)),
          Padding(padding: EdgeInsets.only(bottom: 24)),
          const Center(
            child: Text(
              "YOUR TOKENS IN THIS COLLECTION:",
              style: TextStyle(
                color: Colors.black87,
                fontSize: 20,
              ),
            ),
          ),
          Center(
            child: CollectionImgeScroll(
              tokens: countTokenOccurrences(
                  userCollection.tokens, userCollection.userTokens),
            ),
          ),
          const Text(
            "TRADE REQUEST:",
            style: TextStyle(
              color: Colors.black87,
              fontSize: 20,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 16),
            width: double.maxFinite,
            decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black87, // Change the shadow color as desired
                    blurRadius: 4, // Blur radius
                    offset: Offset(0, 4),
                  ),
                ],
                borderRadius: BorderRadius.circular(8),
                color: AppColors.secondary2 // Creates border
                ),
            padding: EdgeInsets.symmetric(vertical: 24, horizontal: 6),
            child: Text(
              "You currently don’t have any trade requests.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          )
        ],
      ),
    );
  }
}
