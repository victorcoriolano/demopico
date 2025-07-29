import 'package:cached_network_image/cached_network_image.dart';
import 'package:demopico/core/app/theme/theme.dart';
import 'package:demopico/features/mapa/domain/entities/pico_entity.dart';
import 'package:flutter/material.dart';

class PicoCard extends StatelessWidget {
  final Pico pico;
  final VoidCallback? onTap;

  const PicoCard({
    super.key,
    required this.pico,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        clipBehavior: Clip.antiAlias, // Para garantir que a imagem seja cortada
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagem do Pico
            if (pico.imgUrls.isNotEmpty)
              CachedNetworkImage(
                imageUrl: pico.imgUrls.first,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
                errorWidget: (context, error, stackTrace) {
                  return Container(
                    height: 180,
                    color: Colors.grey[300],
                    child: const Center(
                      child: Icon(
                        Icons.image_not_supported,
                        color: Colors.grey,
                        size: 50,
                      ),
                    ),
                  );
                },
              )
            else
              Container(
                height: 180,
                color: Colors.grey[300],
                child: const Center(
                  child: Icon(
                    Icons.no_photography,
                    color: Colors.grey,
                    size: 50,
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nome do Pico
                  Text(
                    pico.picoName,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: kRed,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),

                  // Modalidade e Tipo de Pico
                  Row(
                    children: [
                      Icon(Icons.category, size: 18, color: Colors.grey[700]),
                      const SizedBox(width: 4),
                      Text(
                        '${pico.modalidade} - ${pico.tipoPico}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Descrição 
                    Text(
                      pico.description!,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[800],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),

                  // Avaliação (nota e número de avaliações)
                  Row(
                    children: [
                      const Icon(Icons.star_rate_rounded, color: Colors.amber, size: 20),
                      const SizedBox(width: 4),
                      Text(
                        pico.initialNota.toStringAsFixed(1),
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: kBlack,
                        ),
                      ),
                      Text(
                        ' (${pico.numeroAvaliacoes} avaliações)',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // TODO : AÇÃO DE DETALHES 
                        debugPrint("Detalhes");
                      },
                      icon: const Icon(Icons.info_outline),
                      label: const Text('Ver Detalhes'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: kWhite,
                        backgroundColor: kRed,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
