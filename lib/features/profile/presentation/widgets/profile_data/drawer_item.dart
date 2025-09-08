import 'package:demopico/core/app/theme/theme.dart';
import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;
  const DrawerItem({super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: kWhite, size: 28),
      title: Text(
        text,
        style: const TextStyle(
          color: kWhite,
          fontSize: 16,
        ),
      ),
      onTap: onTap,
    );
  }
}