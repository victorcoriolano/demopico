import 'package:demopico/core/app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBackButton extends StatelessWidget {
  final String destination;
  final double iconSize;
  final Color colorIcon;

  const CustomBackButton(
      {super.key,
      required this.destination,
      this.iconSize = 35,
      this.colorIcon = kBlack});

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
      color: colorIcon,
      splashRadius: 0.5,
      tooltip: "Voltar",
      splashColor: null,
      focusColor: null,
      hoverColor: null,
      iconSize: iconSize,
    );
  }
}
