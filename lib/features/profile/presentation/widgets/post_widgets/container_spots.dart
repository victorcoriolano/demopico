import 'package:demopico/features/mapa/presentation/controllers/spots_controller.dart';
import 'package:demopico/features/profile/presentation/widgets/post_widgets/card_spot_for_profile.dart';
import 'package:demopico/features/user/presentation/controllers/user_database_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContainerSpots extends StatefulWidget {

  const ContainerSpots({ super.key,  });

  @override
  State<ContainerSpots> createState() => _ContainerSpotsState();
}

class _ContainerSpotsState extends State<ContainerSpots> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async { 
      final nameUser = context.read<UserDatabaseProvider>().user!.name;
      await context.read<SpotsControllerProvider>().getMySpots(nameUser);
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