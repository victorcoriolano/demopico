import 'package:demopico/core/app/theme/theme.dart';
import 'package:demopico/features/mapa/presentation/controllers/spots_controller.dart';
import 'package:demopico/features/mapa/presentation/widgets/pico_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MySpotsPage extends StatefulWidget {
  final String idUser;
  const MySpotsPage({super.key, required this.idUser});

  @override
  State<MySpotsPage> createState() => _MySpotsPageState();
}

class _MySpotsPageState extends State<MySpotsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) { 
      context.read<SpotsControllerProvider>().getMySpots(widget.idUser);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MEUS PICOS'),
        centerTitle: true,
      ),
      body: Consumer<SpotsControllerProvider>(
        builder: (context, provider, child) {
          if(provider.isLoading) Center(child: CircularProgressIndicator(),);
          if(provider.mySpots.isEmpty) Center(child: Text("Nenhum pico encontrado", style: TextStyle(color: kRed),),); 
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
