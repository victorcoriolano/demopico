import 'package:demopico/core/common/auth/domain/entities/coletivo_entity.dart';
import 'package:demopico/features/profile/presentation/pages/coletivo_profile_page.dart';
import 'package:demopico/features/profile/presentation/widgets/profile_data/colective_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CollectiveListWidget extends StatelessWidget {
  final List<ColetivoEntity> coletivos;
  const CollectiveListWidget({ super.key, required this.coletivos });

   @override
   Widget build(BuildContext context) {
        final screenWidth = MediaQuery.of(context).size.width;
       return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: coletivos.length,
              padding:
                  EdgeInsets.symmetric(horizontal: (screenWidth * 0.10) / 2),
              itemBuilder: (context, index) {
                final group = coletivos[index];
                return ColectiveCardWidget(
                  coletivo: group,
                  onTap: () {
                    Get.to(() => ColetivoProfilePage(initialColetivoInformation: group),);
                  },
                );
              },
            );
  }
}