import 'package:demopico/core/app/theme/theme.dart';
import 'package:flutter/material.dart';

class PhotoAndNameWidget extends StatelessWidget {
  final String nameUserCreator;
  final String? urlImageUser;
  const PhotoAndNameWidget(
      {super.key, required this.nameUserCreator, required this.urlImageUser});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 80),
      child: Column(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: kRedAccent,
                width: 0.5,
              ),
            ),
            child: CircleAvatar(
                foregroundColor: kWhite,
                backgroundColor: kLightRed,
                backgroundImage:
                    urlImageUser != null ? NetworkImage(urlImageUser!) : null,
                radius: 25,
                child: urlImageUser == null
                    ? Icon(
                        Icons.person,
                        size: 38,
                      )
                    : null),
          ),
          const SizedBox(height: 5),
          Text(
            nameUserCreator,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color.fromARGB(255, 93, 93, 93),
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
