import 'package:demopico/features/mapa/presentation/controllers/map_controller.dart';
import 'package:demopico/features/mapa/presentation/controllers/spot_save_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class SavePicoPage extends StatefulWidget {
  final String userID;
  const SavePicoPage({ super.key , required this.userID});

  @override
  State<SavePicoPage> createState() => _SavePicoPageState();
}

class _SavePicoPageState extends State<SavePicoPage> {
  
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SpotSaveController>(context, listen: true);
    final mapProvider = Provider.of<MapControllerProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Picos Salvos', style: TextStyle(color: Colors.white),),
        backgroundColor: const Color(0xFF8B0000),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          }, 
          
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white,),
        ),
      ),
      body: FutureBuilder(
        future: provider.getPicosSalvos(widget.userID), 
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if(provider.picosSalvos.isEmpty){
            return const Center(child:  Text("Você não possui nenhum pico salvo"));
          }

          if(snapshot.hasError){
            return const Center(child: Text("Algum erro aconteceu"));
          }
          return ListView.builder(
            itemCount: provider.picosSalvos.length,
            itemBuilder: (context, index) {
              var pico = provider.picosSalvos[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                elevation: 5, 
                child: ListTile(
                  minTileHeight: 100,
                  minLeadingWidth: 100,
                  contentPadding: const EdgeInsets.all(16),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      "https://th.bing.com/th?id=OIP.TqFmwMV9lG_Xs_7mhLn1rAHaE8&w=306&h=204&c=8&rs=1&qlt=90&o=6&dpr=1.4&pid=3.1&rm=2",
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(
                    pico.picoName,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    pico.userCreator ?? 'Anônimmo', 
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  trailing:  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        tooltip: "Localização no mapa",
                        icon: const Icon(Icons.location_on, color: Colors.blue),
                        onPressed: () {
                          mapProvider.reajustarCameraPosition(LatLng(pico.lat, pico.long));
                          Navigator.pop(context);
                        },
                      ),
                      IconButton(
                        tooltip: "Deletar Pico",
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () async {
                          final deletar =  await provider.deleteSave(pico.picoName, widget.userID);
                          if(context.mounted){
                            if(deletar){
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Pico ${pico.picoName} removido dos excluidos"),
                                ),
                              );
                            }else{
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Não foi possivel remover: ${pico.picoName} "),
                                ),
                              );
                            }
                          }
                        },
                      ),
                    ],
                  ),
                  onTap: () { 
                    mapProvider.reajustarCameraPosition(LatLng(pico.lat, pico.long));
                    Navigator.pop(context);
                  },
                  
                ),
                
              );
            },
          );
        },
      ),
    );
  }
}
