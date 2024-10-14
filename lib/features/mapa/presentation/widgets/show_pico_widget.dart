import 'package:demopico/features/mapa/domain/entities/pico_entity.dart';
import 'package:flutter/material.dart';

class ShowPicoWidget extends StatefulWidget {
  final Pico pico;

  const ShowPicoWidget({super.key, required this.pico});

  @override
  State<ShowPicoWidget> createState() => _ShowPicoWidgetState();
}

class _ShowPicoWidgetState extends State<ShowPicoWidget> {
  List<String> images = [
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQTIZccfNPnqalhrWev-Xo7uBhkor57_rKbkw&usqp=CAU",
    "https://wallpaperaccess.com/full/2637581.jpg",
    "https://images.wallpapersden.com/image/download/purple-sunrise-4k-vaporwave_bGplZmiUmZqaraWkpJRmbmdlrWZlbWU.jpg",
    "https://uhdwallpapers.org/uploads/converted/20/01/14/the-mandalorian-5k-1920x1080_477555-mm-90.jpg"
  ];
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.2, // Tamanho inicial do painel (20%)
      minChildSize: 0.0, // Tamanho mínimo ao deslizar para baixo
      maxChildSize: 0.95, // Tamanho máximo ao deslizar para cima
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                spreadRadius: 2,
                blurRadius: 10,
              ),
            ],
          ),
          child: ListView(
            controller: scrollController,
            children: [
              // Barra de arrastar
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 250,
                    child: PageView.builder(
                      itemCount: images.length,
                      pageSnapping: true,
                      itemBuilder: (context, pagePosition) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(30)),
                          ),
                          clipBehavior: Clip
                              .hardEdge, // Adiciona o clipping para respeitar o borderRadius
                          child: Image.network(
                            images[pagePosition],
                            fit: BoxFit.cover, // Ajusta a imagem
                          ),
                        );
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: EdgeInsets.only(top: 10),
                      height: 5,
                      width: 80,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 240, 238, 238),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),

              const ListTile(
                title: Text('Detalhes do Local'),
                subtitle: Text('Informações do local clicado no mapa'),
              ),
              const ListTile(
                title: Text('Mais detalhes'),
                subtitle: Text('Você pode adicionar mais informações aqui.'),
              ),
              // Adicione outros elementos conforme necessário
            ],
          ),
        );
      },
    );
  }
}
