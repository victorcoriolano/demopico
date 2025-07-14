import 'package:demopico/core/app/theme/theme.dart';
import 'package:demopico/features/profile/presentation/widgets/profile_data/text_stats_profile_widget.dart';
import 'package:flutter/material.dart';

class ProfileBottomSideDataWidget extends StatelessWidget {
  final int followers;
  final int contributions;
  final String description;
  final bool isScrolling;


  const ProfileBottomSideDataWidget(
      {super.key,
      required this.followers,
      required this.contributions,
      required this.description,
       this.isScrolling = false,});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(
              horizontal: (screenWidth * 0.10) / 2, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextStatsProfileWidget(info: followers.toString(), legend: 'SEGUIDORES'),
              TextStatsProfileWidget(info: contributions.toString(), legend: 'CONTRIBUIÇÕES'),
            ],
          ),
        ),
        Center(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: kWhite,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10),
            ),
            width: screenWidth > 600 ? screenWidth - 100 : screenWidth - 50,
            child: Text(
              textAlign: TextAlign.center,
              description,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        )
      ],
    );
  }
}
