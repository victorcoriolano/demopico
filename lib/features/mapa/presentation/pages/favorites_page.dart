import 'package:demopico/features/mapa/presentation/controllers/map_controller.dart';
import 'package:demopico/features/mapa/presentation/controllers/favorite_spot_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class FavoriteSpotPage extends StatefulWidget {
  final String userID;
  const FavoriteSpotPage({super.key, required this.userID});

  @override
  State<FavoriteSpotPage> createState() => _FavoriteSpotPageState();
}

class _FavoriteSpotPageState extends State<FavoriteSpotPage> {
  void getSpots() async {
    await context.read<FavoriteSpotController>().getPicosSalvos(widget.userID);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) { 
      getSpots();  
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Picos Favoritos',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF8B0000),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.white,
          ),
        ),
      ),
      body: Consumer2<FavoriteSpotController, MapControllerProvider>(
        builder: (context, provider, mapController, child) {
          if (provider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (provider.picosFavoritos.isEmpty) {
            return const Center(
                child: Text("Você não possui nenhum pico salvo"));
          }

          if (provider.error != null) {
            return Center(
                child: Text("Erro ao carregar os dados: ${provider.error}"));
          }
          return ListView.builder(
            itemCount: provider.picosFavoritos.length,
            itemBuilder: (context, index) {
              var pico = provider.picosFavoritos[index];
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
                      pico.picoModel.imgUrls.first,
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(
                    pico.picoModel.picoName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    pico.picoModel.userName ?? 'Anônimmo',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        tooltip: "Localização no mapa",
                        icon: const Icon(Icons.location_on, color: Colors.blue),
                        onPressed: () {
                          mapController.reajustarCameraPosition(
                              LatLng(pico.picoModel.lat, pico.picoModel.long));
                          if (context.mounted) Navigator.pop(context);
                        },
                      ),
                      IconButton(
                        tooltip: "Remover Favorito",
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () async {
                          final deletar = await provider
                              .deleteSave(pico.picoFavoritoModel.id);
                          if (context.mounted) {
                            if (deletar) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      "Pico ${pico.picoModel.picoName} removido com sucesso"),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      "Ocorreu um erro ao remover ${pico.picoModel.picoName} dos favoritos"),
                                ),
                              );
                            }
                          }
                        },
                      ),
                    ],
                  ),
                  onTap: () {
                    mapController.reajustarCameraPosition(
                        LatLng(pico.picoModel.lat, pico.picoModel.long));
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
