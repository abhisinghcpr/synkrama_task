import 'package:flutter/material.dart';
import '../utils/colors/app_color.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MaterialButton(
        minWidth: 313,
        height: 50,
        elevation: 0,
        color: AppColors.primaryColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
    );
  }
}
