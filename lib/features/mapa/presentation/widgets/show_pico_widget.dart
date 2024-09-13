import 'package:flutter/material.dart';

class ShowPicoWidget extends StatefulWidget {
  const ShowPicoWidget({super.key});
  
  @override
  State<ShowPicoWidget> createState() => _ShowPicoWidgetState();
}
class _ShowPicoWidgetState extends State<ShowPicoWidget> {
  @override
  Widget build(BuildContext context) {
    return   DraggableScrollableSheet(
            initialChildSize: 0.2, // Tamanho inicial do painel (20%)
            minChildSize: 0.0, // Tamanho mínimo ao deslizar para baixo
            maxChildSize: 0.95, // Tamanho máximo ao deslizar para cima
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
                        margin: EdgeInsets.symmetric(vertical: 10),
                        height: 5,
                        width: 80, // Largura desejada da barra de arrastar
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 137, 137, 137),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),

                    ListTile(
                      title: Text('Detalhes do Local'),
                      subtitle: Text('Informações do local clicado no mapa'),
                    ),
                    ListTile(
                      title: Text('Mais detalhes'),
                      subtitle:
                          Text('Você pode adicionar mais informações aqui.'),
                    ),
                    // Adicione outros elementos conforme necessário
                  ],
                ),
              );
            },
          );
  }
}