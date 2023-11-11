import 'package:fitfutures/consts/app_colors.dart';
import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  const InputField({super.key, required this.label, required this.controller});

  final String label;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(bottom: 1),
          labelStyle: const TextStyle(
              color: AppColors.secondary2, fontWeight: FontWeight.bold),
          border: const UnderlineInputBorder(
              borderSide: BorderSide(
            color: AppColors.secondary2,
            width: 3,
          )),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.secondary2),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.secondary2),
          ),
          fillColor: AppColors.secondary2,
          labelText: label,
        ),
      ),
    );
  }
}
