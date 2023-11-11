import 'package:fitfutures/consts/app_colors.dart';
import 'package:fitfutures/model/token.dart';
import 'package:fitfutures/model/user_token.dart';
import 'package:flutter/material.dart';

class ImageRow extends StatelessWidget {
  final List<Token> images; // Replace with your actual image URLs or paths
  final List<int> userTokens;

  const ImageRow({super.key, required this.images, required this.userTokens});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.all(0),
        itemCount:
            ((images.length + 3) / 4).floor(), // Calculate the number of rows
        itemBuilder: (context, rowIndex) {
          int startIndex = rowIndex * 4;
          int endIndex = (rowIndex + 1) * 4;
          List<Token> rowTokens = images.sublist(
            startIndex,
            endIndex < images.length ? endIndex : images.length,
          );
          return Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment:
                MainAxisAlignment.center, // Set this to MainAxisSize.min
            children: rowTokens.map((token) {
              return userTokens.contains(token.id)
                  ? Image.memory(
                      token.pictureBytes,
                    )
                  : Opacity(
                      opacity: 0.5,
                      child: Image.memory(
                        token.pictureBytes,
                      ),
                    );
            }).toList(),
          );
        },
      ),
    );
  }
}
