import 'package:demopico/core/app/theme/theme.dart';
import 'package:demopico/core/common/auth/domain/entities/user_identification.dart';
import 'package:demopico/features/profile/domain/models/profile_user.dart';
import 'package:demopico/features/profile/presentation/pages/coletivo_profile_page.dart';
import 'package:demopico/features/profile/presentation/pages/create_colective_page.dart';
import 'package:demopico/features/profile/presentation/view_model/collective_view_model.dart';
import 'package:demopico/features/profile/presentation/widgets/profile_data/colective_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class CollectiveSectionWidget extends StatefulWidget {
  final Profile profile;
  const CollectiveSectionWidget({super.key, required this.profile});

  @override
  State<CollectiveSectionWidget> createState() => _CollectiveSectionWidgetState();
}

class _CollectiveSectionWidgetState extends State<CollectiveSectionWidget> {
  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) { 
      context.read<CollectiveViewModel>().getCollectives(widget.profile.userID);
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Consumer<CollectiveViewModel>(builder: (context, vm, child) {
      if (vm.isLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (vm.collectives.isEmpty) {
        return Container(
          height: 80,
          width: double.infinity,
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(horizontal: (screenWidth * 0.10) / 2),
          decoration: BoxDecoration(
            color: kWhite.withValues(alpha: .5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Você não participa de nenhum coletivo",
                style: TextStyle(color: kMediumGrey, fontSize: 13),
              ),
              IconButton(
                  onPressed: () {
                    Get.to(() => CreateCollectivePage(user: widget.profile),);
                  },
                  icon: Icon(Icons.add))
            ],
          ),
        );
      }

      return SizedBox(
        height: 120,
        child: Stack(
          children: [
            ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: vm.collectives.length,
              padding:
                  EdgeInsets.symmetric(horizontal: (screenWidth * 0.10) / 2),
              itemBuilder: (context, index) {
                final group = vm.collectives[index];
                return ColectiveCardWidget(
                  coletivo: group,
                  onTap: () {
                    Get.to(() => ColetivoProfilePage(initialColetivoInformation: group),);
                  },
                );
              },
            ),
            Positioned(
              top: 0,
              right: 30,
              child: IconButton(
                tooltip: "Criar grupo",
                onPressed: () {
                  Get.to(() => CreateCollectivePage(user: widget.profile), );
                },
                icon: Icon(Icons.group_add),
              ),
            ),
          ],
        ),
      );
    });
  }
}
