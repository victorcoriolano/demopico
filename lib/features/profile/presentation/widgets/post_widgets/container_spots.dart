import 'package:demopico/core/common/auth/domain/entities/user_entity.dart';
import 'package:demopico/features/mapa/presentation/controllers/spots_controller.dart';
import 'package:demopico/features/profile/presentation/services/verify_auth_and_get_user.dart';
import 'package:demopico/features/profile/presentation/widgets/post_widgets/card_spot_for_profile.dart';
import 'package:demopico/features/user/presentation/controllers/auth_view_model_account.dart';
import 'package:demopico/features/user/presentation/controllers/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContainerSpots extends StatefulWidget {
  final UserEntity user;
  const ContainerSpots({ super.key, required this.user  });

  @override
  State<ContainerSpots> createState() => _ContainerSpotsState();
}

class _ContainerSpotsState extends State<ContainerSpots> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async { 
      final user = context.read<AuthViewModelAccount>().user;
      switch (user){
        
        case UserEntity():
          await context.read<SpotsControllerProvider>().getMySpots(user.displayName.value);

        case AnonymousUserEntity():
          // do nothing
      }
    });
  }

   @override
   Widget build(BuildContext context) {
       return Consumer<SpotsControllerProvider>(builder: (context, provider, child) {
      if (provider.isLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      else if (provider.mySpots.isEmpty) {
        return const Center(
          child: Text('Nenhum post encontrado'),
        );
      }

      final listSpots = provider.mySpots;
      
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1,
          ),
          itemCount: listSpots.length,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.all(0.8),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
              child: Center(child: CardSpotForProfile(pico: listSpots[index],)),
            );
          },
        ),
      );
    });
  }
}