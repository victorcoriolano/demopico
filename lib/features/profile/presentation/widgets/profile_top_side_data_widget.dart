import 'package:flutter/material.dart';

class ProfileTopSideDataWidget extends StatelessWidget {

  final String? avatarUrl;
  final String? backgroundUrl;
  final double avatarSize;
  const ProfileTopSideDataWidget({
    super.key,

    required this.avatarUrl,
    required this.backgroundUrl,
    this.avatarSize = 80,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: double.infinity,
              height: 175,
              decoration: BoxDecoration(
                image: DecorationImage(
                  alignment: Alignment.center,
                  image: backgroundUrl != null && backgroundUrl!.isNotEmpty
                      ? NetworkImage(backgroundUrl!)
                      : const AssetImage("images/backgroundPadrao.png")
                          as ImageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: -avatarSize,
              left: (screenWidth - avatarSize * 2) / 2,
              child: CircleAvatar(
                radius: avatarSize,
                backgroundColor: Colors.white,
                child: ClipOval(
                  child: avatarUrl != null && avatarUrl!.isNotEmpty
                      ? Image.network(
                          avatarUrl!,
                          width: avatarSize * 1.9,
                          height: avatarSize * 1.9,
                          fit: BoxFit.cover,
                        )
                      : const Icon(Icons.person, size: 40),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
