import 'package:fitfutures/consts/app_colors.dart';
import 'package:fitfutures/model/token.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CollectionImgeScroll extends StatelessWidget {
  final Map<Token, int> tokens; // Replace with your actual image URLs or paths

  const CollectionImgeScroll({super.key, required this.tokens});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: tokens.keys.map((token) {
          return Container(
            margin: EdgeInsets.all(8.0),
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width / 4 - 16),
            child: Column(
              children: [
                Image.memory(token.pictureBytes),
                Text("${tokens[token].toString()}x"),
                ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                      shape: MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      backgroundColor:
                          MaterialStatePropertyAll(AppColors.primary1)),
                  child: const Text(
                    "Trade",
                    style: TextStyle(
                      color: AppColors.secondary1,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                )
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
