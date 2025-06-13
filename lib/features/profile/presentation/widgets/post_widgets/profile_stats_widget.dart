import 'package:flutter/material.dart';

class ProfileStatsWidget extends StatelessWidget {
  final int? followers;
  final int? contributions;

  const ProfileStatsWidget({
    super.key,
    required this.followers,
    required this.contributions,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: (screenWidth * 0.10) / 2, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                '$followers',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'SEGUIDORES',
                style: TextStyle(
                  fontSize: 10,
                  letterSpacing: 1,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Text(
                '$contributions',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'CONTRIBUIÇÕES',
                style: TextStyle(
                  fontSize: 10,
                  letterSpacing: 1,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
