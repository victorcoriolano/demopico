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
          margin: const EdgeInsets.only(top: 10, bottom: 10),
          
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10),
            color: const Color.fromARGB(255, 248, 246, 246),
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
