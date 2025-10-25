import 'package:demopico/core/app/theme/theme.dart';
import 'package:demopico/core/common/auth/domain/entities/user_entity.dart';
import 'package:demopico/features/profile/presentation/object_for_only_view/suggestion_profile.dart';
import 'package:demopico/features/profile/presentation/pages/create_colective_page.dart';
import 'package:demopico/features/profile/presentation/pages/create_post_page.dart';
import 'package:demopico/features/profile/presentation/view_model/network_view_model.dart';
import 'package:demopico/features/user/presentation/controllers/auth_view_model_account.dart';
import 'package:demopico/features/user/presentation/widgets/textfield_decoration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

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
              margin: const EdgeInsets.all(5),
              width: double.infinity,
              height: 175,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16)),
                image: DecorationImage(
                  alignment: Alignment.center,
                  image: backgroundUrl != null && backgroundUrl!.isNotEmpty
                      ? NetworkImage(backgroundUrl!)
                      : const AssetImage(
                              "assets/images/background_vermelho.png")
                          as ImageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: -avatarSize,
              left: (screenWidth - avatarSize * 2) / 2,
              child: Stack(
                children: [
                  CircleAvatar(
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
                ],
              ),
            ),
            
          ],
        ),
      ],
    );
  }

 
}
