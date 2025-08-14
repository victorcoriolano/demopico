import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBackButton extends StatelessWidget {
  final String destination;
  final double iconSize;

  const CustomBackButton({
    super.key,
    required this.destination,
    this.iconSize = 35,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Get.toNamed(
          destination,
          preventDuplicates: true,
        );
      },
      icon: const Icon(Icons.arrow_back),
      color: const Color.fromARGB(255, 0, 0, 0),
      splashRadius: 0.5,
      tooltip: "Voltar",
      splashColor: null,
      focusColor: null,
      hoverColor: null,
      iconSize: iconSize,
    );
  }
}
