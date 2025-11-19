import 'package:demopico/core/app/theme/theme.dart';
import 'package:demopico/core/common/auth/domain/entities/coletivo_entity.dart';
import 'package:flutter/material.dart';

class ColectiveCardWidget extends StatelessWidget {
  final ColetivoEntity coletivo;
  final VoidCallback onTap;

  const ColectiveCardWidget({ super.key, required this.coletivo, required this.onTap });

   @override
   Widget build(BuildContext context) {
       return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 110,
        margin: const EdgeInsets.symmetric(horizontal: 6),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color.fromARGB(143, 255, 255, 255), 
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 5,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(coletivo.logo),
              radius: 34,
              backgroundColor: kMediumGrey.withValues(alpha: 0.2),
            ),
            const SizedBox(height: 8),
            Text(
              coletivo.nameColetivo,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
