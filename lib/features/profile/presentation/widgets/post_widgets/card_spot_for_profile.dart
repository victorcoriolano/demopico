import 'package:cached_network_image/cached_network_image.dart';
import 'package:demopico/core/app/theme/theme.dart';
import 'package:demopico/features/mapa/domain/entities/pico_entity.dart';
import 'package:demopico/features/mapa/presentation/view_services/modal_helper.dart';
import 'package:flutter/material.dart';

class CardSpotForProfile extends StatelessWidget {
  final Pico pico;
  const CardSpotForProfile({ super.key, required this.pico });

   @override
   Widget build(BuildContext context) {
       return GestureDetector(
      onTap: () {
        ModalHelper.openModalInfoPico(context, pico);
      },
      
      child: Card(
        margin: const EdgeInsets.all(0),
        color: kLightGrey,
        shape: LinearBorder(),
        clipBehavior: Clip.antiAlias,
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: pico.imgUrls.first,
          progressIndicatorBuilder: (context, url, progress) => CircularProgressIndicator(value: progress.progress,),
          errorWidget: (context, url, error) => Center(child: Icon(Icons.broken_image_sharp),),),
      ),
    );
  }
}