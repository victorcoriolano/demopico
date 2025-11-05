import 'package:demopico/core/app/routes/app_routes.dart';
import 'package:demopico/core/app/theme/theme.dart';
import 'package:demopico/features/profile/presentation/widgets/profile_data/text_stats_profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileBottomSideDataWidget extends StatelessWidget {
  final String idUser;
  final String nameUser;
  final int followers;
  final int contributions;
  final String description;
  final bool isScrolling;
 


  const ProfileBottomSideDataWidget(

      {super.key,
      required this.idUser,
      required this.nameUser,
      required this.followers,
      required this.contributions,
      required this.description,
       this.isScrolling = false,});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(
              horizontal: (screenWidth * 0.10) / 2, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextStatsProfileWidget(
                info: followers.toString(), 
                legend: 'CONEXÕES',
                onTap: () => Get.toNamed(Paths.connections  , arguments: idUser),),
              TextStatsProfileWidget(info: contributions.toString(), legend: 'CONTRIBUIÇÕES',
              onTap: () => Get.toNamed(Paths.mySpots, arguments: nameUser),),
            ],
          ),
        ),
       
        
        
        
        SizedBox(height: 12,),
        Center(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: kWhite,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10),
            ),
            width: screenWidth > 600 ? screenWidth - 100 : screenWidth - 50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "BIO",
                  style: const TextStyle(fontSize: 12, color: kMediumGrey, fontWeight: FontWeight.bold),
                ),
                Text(
                  textAlign: TextAlign.justify,
                  description,
                  style: const TextStyle(fontSize: 16,),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 12,),
         
                
      ],
    );
  }
}
