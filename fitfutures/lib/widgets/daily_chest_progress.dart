import 'package:fitfutures/consts/app_colors.dart';
import 'package:flutter/material.dart';

class DashedProgressBar extends StatelessWidget {
  final Future<int> currentStep;
  List<int> numbers = List.generate(5, (index) => index + 1);

  DashedProgressBar({super.key, required this.currentStep});

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
              offset: Offset(0, 4), // X and Y offset
            ),
          ],
          border: Border.all(color: AppColors.secondary1, width: 1),
          borderRadius: BorderRadius.circular(8),
          color: AppColors.secondary2 // Creates border
          ),
      child: FutureBuilder<int>(
        future: currentStep,
        builder: (context, snapshot) {
          return snapshot.data != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: numbers
                          .map((e) => Container(
                                width: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: e <= snapshot.data!
                                        ? AppColors.secondary1
                                        : AppColors.primary1),
                                height: 10,
                              ))
                          .toList(),
                    ),
                    const Padding(padding: EdgeInsets.only(bottom: 12)),
                    Text(
                      "${snapshot.data!}/5 DONE!",
                      style: const TextStyle(fontSize: 16),
                    )
                  ],
                )
              : CircularProgressIndicator();
        },
      ),
    );
  }
}
