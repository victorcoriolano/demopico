import 'package:demopico/core/app/theme/theme.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String textButton;
  const CustomElevatedButton(
      {super.key, required this.onPressed, required this.textButton});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: kRed,
        padding: const EdgeInsets.symmetric(
          horizontal: 50,
          vertical: 10,
        ),
      ),
      onPressed: onPressed,
      child: Text(
        textButton,
        style: TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class CustomOutlineButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String textButton;
  const CustomOutlineButton(
      {super.key, required this.onPressed, required this.textButton});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: kRed),
        backgroundColor: kWhite,
      ),
      child: Text(
        textButton,
        style: TextStyle(
            color: kRed, // Texto vermelho
            fontWeight: FontWeight.bold,
            fontSize: 12),
      ),
    );
  }
}
