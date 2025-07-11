import 'package:demopico/core/app/theme/theme.dart';
import 'package:flutter/material.dart';

class ProfileActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final double iconSize;

  const ProfileActionButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.iconSize = 40,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(icon),
          iconSize: iconSize,
          color: kBlack,
          onPressed: onPressed,
        ),
      ],
    );
  }
}
