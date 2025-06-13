import 'package:flutter/material.dart';

class ProfileDescriptionWidget extends StatelessWidget {
  final String? description;

  const ProfileDescriptionWidget({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10),
          ),
          width: screenWidth > 600 ? 400 : null,
          alignment: Alignment.center,
          child: Text(
            textAlign: TextAlign.center,
            description ?? '',
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
