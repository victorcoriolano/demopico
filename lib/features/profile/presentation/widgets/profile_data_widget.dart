import 'package:flutter/material.dart';

class ProfileDataWidget extends StatelessWidget {
  final String? name;
  final String? avatarUrl;
  final String? backgroundUrl;
  final String? description;
  final int? followers;
  final int? contributions;
  final double avatarSize;

  const ProfileDataWidget({
    super.key,
    required this.name,
    required this.avatarUrl,
    required this.backgroundUrl,
    required this.description,
    required this.followers,
    required this.contributions,
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
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
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
        const SizedBox(height: 100),
        Text(
          name ?? 'Nome de usuário não encontrado...',
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),

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
