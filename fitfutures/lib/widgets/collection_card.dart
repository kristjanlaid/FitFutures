import 'package:fitfutures/consts/app_colors.dart';
import 'package:fitfutures/model/user_collection.dart';
import 'package:fitfutures/widgets/image_row.dart';
import 'package:flutter/material.dart';

class CollectionCard extends StatelessWidget {
  const CollectionCard({Key? key, required this.userCollection})
      : super(key: key);

  final UserCollection userCollection;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.only(top: 12, bottom: 12, left: 24, right: 24),
      decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Colors.black87, // Change the shadow color as desired
              blurRadius: 4, // Blur radius
              offset: Offset(0, 4),
            ),
          ],
          border: Border.all(color: AppColors.secondary1, width: 1),
          borderRadius: BorderRadius.circular(8),
          color: AppColors.secondary2 // Creates border
          ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            userCollection.name,
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.primary1),
          ),
          ImageRow(
            images: userCollection.tokens,
            userTokens:
                userCollection.userTokens.map((e) => e.tokenId).toList(),
          ),
          Text(
            "${userCollection.userTokens.length}/${userCollection.tokens.length} COLLECTED",
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.primary1,
            ),
          )
        ],
      ),
    );
  }
}
