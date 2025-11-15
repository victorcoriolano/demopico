import 'package:demopico/core/app/routes/app_routes.dart';
import 'package:demopico/core/app/theme/theme.dart';
import 'package:demopico/features/mapa/domain/entities/pico_favorito.dart';
import 'package:demopico/features/mapa/presentation/controllers/map_controller.dart';
import 'package:demopico/features/mapa/presentation/controllers/favorite_spot_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class FavoriteSpotPage extends StatefulWidget {
  const FavoriteSpotPage({
    super.key,
  });

  @override
  State<FavoriteSpotPage> createState() => _FavoriteSpotPageState();
}

class _FavoriteSpotPageState extends State<FavoriteSpotPage> {
  final String userID = Get.arguments as String;

  void getSpots() async {
    final provider = context.read<FavoriteSpotController>();
    await provider.getPicosSalvos(userID);
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
          if (provider.error != null) {
            return Center(
                child: Text("Erro ao carregar os dados: ${provider.error}"));
          }
          if (provider.picosFavoritos.isEmpty) {
            return const Center(
                child: Text("Você não possui nenhum pico salvo"));
          }

          return ListView.builder(
            itemCount: provider.picosFavoritos.length,
            itemBuilder: (context, index) {
              var pico = provider.picosFavoritos[index];

              return Card(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 6,
                child: InkWell(
                  borderRadius: BorderRadius.circular(14),
                  onTap: () {
                    final latlang = LatLng(pico.pico.location.latitude,
                        pico.pico.location.longitude);

                    mapController.reajustarCameraPosition(latlang);
                    Get.toNamed(Paths.map, arguments: latlang);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // IMAGEM
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: pico.pico.imgUrls.firstOrNull != null
                              ? Image.network(
                                  pico.pico.imgUrls.first,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                )
                              : Container(
                                  width: 100,
                                  height: 100,
                                  color: Colors.grey.shade300,
                                  child: const Icon(Icons.image,
                                      color: Colors.white),
                                ),
                        ),

                        const SizedBox(width: 16),

                        // TEXTOS
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                pico.pico.picoName,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                pico.pico.user?.name ?? 'Anônimo',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(width: 10),

                        // ÍCONES NA DIREITA
                        Column(
                          children: [
                            IconButton(
                              tooltip: "Localização no mapa",
                              icon: const Icon(Icons.location_on,
                                  color: kRed, size: 26),
                              onPressed: () {
                                mapController.reajustarCameraPosition(
                                  LatLng(
                                    pico.pico.location.latitude,
                                    pico.pico.location.longitude,
                                  ),
                                );
                                if (context.mounted) Navigator.pop(context);
                              },
                            ),
                            IconButton(
                              tooltip: "Remover Favorito",
                              icon: const Icon(Icons.delete,
                                  color: kRed, size: 26),
                              onPressed: () async {
                                final picoFav = pico.picoFavoritoModel;
                                final deletar = await provider
                                    .deleteSave(PicoFavorito(idPicoFavorito: picoFav.id, idPico: picoFav.idPico, idUsuario: picoFav.idUsuario));

                                if (!context.mounted) return;

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: kRed,
                                    content: Text(
                                      deletar
                                          ? "Pico ${pico.pico.picoName} removido com sucesso"
                                          : "Erro ao remover ${pico.pico.picoName} dos favoritos",
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
