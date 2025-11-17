import 'package:demopico/core/app/theme/theme.dart';
import 'package:demopico/features/mapa/presentation/controllers/spots_controller.dart';
import 'package:demopico/features/mapa/presentation/widgets/pico_card.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

class MySpotsPage extends StatefulWidget {

  const MySpotsPage({super.key, });

  @override
  State<MySpotsPage> createState() => _MySpotsPageState();
}

class _MySpotsPageState extends State<MySpotsPage> {
  final idName = Get.arguments[0] as String;
  final idUser = Get.arguments[1] as String;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) { 
      debugPrint("myspotspage - userid: $idName");
      context.read<SpotsControllerProvider>().getMySpots(idUser);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PICOS - $idName'),
        centerTitle: true,
      ),
      body: Consumer<SpotsControllerProvider>(
        builder: (context, provider, child) {
          if(provider.isLoading) return Center(child: CircularProgressIndicator(),);
          if(provider.mySpots.isEmpty) return Center(child: Text("Nenhum pico encontrado", style: TextStyle(color: kRed),),); 
          return ListView.builder(
            itemBuilder: (context, item) =>
                PicoCard(pico: provider.mySpots[item]),
            itemCount: provider.mySpots.length,
            shrinkWrap: true,
          );
        },
      ),
    );
  }
}
