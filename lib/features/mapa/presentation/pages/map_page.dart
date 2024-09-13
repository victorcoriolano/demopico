import 'package:flutter/material.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  bool _isPanelVisible = false; // Controla a visibilidade do painel

  // Função chamada quando um ponto no mapa é clicado
  void _onMapPointTapped() {
    setState(() {
      _isPanelVisible = true; // Exibe o painel ao clicar em um ponto
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Simulação do widget de mapa (substitua pelo widget real)
        GestureDetector(
          onTap: _onMapPointTapped, // Simula o clique no ponto do mapa
          child: Container(
            color: Colors.blue, // Substitua pelo widget de mapa real
            child: const Center(
              child: Text(
                'Clique no mapa para abrir o painel',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
        ),

        // Painel arrastável (oculto até o clique no mapa)
        if (_isPanelVisible)
          DraggableScrollableSheet(
            initialChildSize: 0.2, // Tamanho inicial do painel (20%)
            minChildSize: 0.2, // Tamanho mínimo ao deslizar para baixo
            maxChildSize: 0.8, // Tamanho máximo ao deslizar para cima
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
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
                    Align(
                      alignment:
                          Alignment.center, // Centraliza a barra no painel
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        height: 5,
                        width: 8 * 0, // Largura desejada da barra de arrastar
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 0, 0, 0),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),

                    const ListTile(
                      title: Text('Detalhes do Local'),
                      subtitle: Text('Informações do local clicado no mapa'),
                    ),
                    const ListTile(
                      title: Text('Mais detalhes'),
                      subtitle:
                          Text('Você pode adicionar mais informações aqui.'),
                    ),
                    // Adicione outros elementos conforme necessário
                  ],
                ),
              );
            },
          ),
      ],
    );
  }
}
