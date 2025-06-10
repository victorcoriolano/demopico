import 'package:flutter/material.dart';

class ProfileBottomSideDataWidget extends StatelessWidget {
  final int? followers;
  final int? contributions;
  final String? description;


  const ProfileBottomSideDataWidget({
    super.key,
    required this.followers,
    required this.contributions,
    required this.description
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(
              horizontal: (screenWidth * 0.20) / 2, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$followers\nSeguidores',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              Text(
                '$contributions\nContribuições',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
        )
      ],
    );
  }
}
