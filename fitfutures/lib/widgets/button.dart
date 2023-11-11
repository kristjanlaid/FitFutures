import 'package:fitfutures/consts/app_colors.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button(
      {Key? key,
      required this.color,
      required this.label,
      required this.onPressed})
      : super(key: key);

  final Color color;
  final String label;
  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            side: const BorderSide(width: 2, color: AppColors.primary1),
            elevation: 4.0,
            shadowColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: MaterialStateColor.resolveWith((states) {
              if (states.contains(MaterialState.pressed)) {
                return color.withOpacity(0.01);
              }
              return color;
            }),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 14, bottom: 14),
                child: Text(
                  label,
                  style: const TextStyle(
                      color: AppColors.primary1,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              )
            ],
          ),
        ));
  }
}
