import 'package:flutter/material.dart';

class ProfileBottomSideDataWidget extends StatelessWidget {
  final int? followers;
  final int? contributions;
  final String? description;
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
              horizontal: (screenWidth * 0.10) / 2, vertical: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    '$followers',
                    style: const TextStyle(
                      fontSize: 18, // maior para o número
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'SEGUIDORES',
                    style: TextStyle(
                      fontSize: 10, // menor para o texto
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
                      fontSize: 18, // maior para o número
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'CONTRIBUIÇÕES',
                    style: TextStyle(
                      fontSize: 10, // menor para o texto
                      letterSpacing: 1,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric( horizontal: 10),
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
