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
                      : const AssetImage("assets/images/backgroundPadrao.png")
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
          name ?? 'Usuário não encontrado...',
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              '$followers\nSeguidores',
              textAlign: TextAlign.center,
            ),
            Text(
              '$contributions\nContribuições',
              textAlign: TextAlign.center,
            ),
          ],
        ),
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromARGB(176, 196, 196, 196),
              border: Border.all(color: Colors.black, width: 1),
            ),
            width: screenWidth > 600 ? 400 : null,
            alignment: Alignment.center,
            child: Text(
              description ?? '',
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ),
      ],
    );
  }
}
