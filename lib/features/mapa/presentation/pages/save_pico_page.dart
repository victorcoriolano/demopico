import 'package:demopico/features/mapa/presentation/controllers/map_controller.dart';
import 'package:demopico/features/mapa/presentation/controllers/favorite_spot_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class SavePicoPage extends StatefulWidget {
  final String userID;
  const SavePicoPage({super.key, required this.userID});

  @override
  State<SavePicoPage> createState() => _SavePicoPageState();
}

class _SavePicoPageState extends State<SavePicoPage> {
  @override
  Widget build(BuildContext context) {
    final mapProvider =
        Provider.of<MapControllerProvider>(context, listen: true);
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
      body: Consumer<FavoriteSpotController>(
        builder: (context, provider, child) => FutureBuilder(
          future: provider.getPicosSalvos(widget.userID),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (provider.picosFavoritos.isEmpty) {
              return const Center(
                  child: Text("Você não possui nenhum pico salvo"));
            }

            if (snapshot.hasError) {
              return const Center(child: Text("Algum erro aconteceu"));
            }
            return ListView.builder(
              itemCount: provider.picosFavoritos.length,
              itemBuilder: (context, index) {
                var pico = provider.picosFavoritos[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
                      pico.picoModel.userCreator ?? 'Anônimmo',
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
                          icon:
                              const Icon(Icons.location_on, color: Colors.blue),
                          onPressed: () {
                            mapProvider.reajustarCameraPosition(LatLng(
                                pico.picoModel.lat, pico.picoModel.long));
                            Navigator.pop(context);
                          },
                        ),
                        IconButton(
                          tooltip: "Deletar Pico",
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
                      mapProvider.reajustarCameraPosition(
                          LatLng(pico.picoModel.lat, pico.picoModel.long));
                      Navigator.pop(context);
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
