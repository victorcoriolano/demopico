import 'package:demopico/features/mapa/domain/entities/pico_entity.dart';
import 'package:flutter/material.dart';
import 'package:icon_decoration/icon_decoration.dart';

class ShowPicoWidget extends StatefulWidget {
  final Pico pico;
  final ScrollController scrollController;
  const ShowPicoWidget(
      {super.key, required this.pico, required this.scrollController});

  @override
  State<ShowPicoWidget> createState() => _ShowPicoWidgetState();
}

class _ShowPicoWidgetState extends State<ShowPicoWidget> {
  List<String> images = [];

  void _loadPicos() {
    setState(() {
      images = widget.pico.imgUrl.cast<String>(); //url pico
    });
  }

  @override
  void initState() {
    super.initState();
    _loadPicos(); // carregar img
  }

  @override
  Widget build(BuildContext context) {
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
        controller: widget.scrollController,
        children: [
          // Barra de arrastar
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 270,
                child: images.isNotEmpty
                    ? PageView.builder(
                        itemCount: images.length,
                        pageSnapping: true,
                        itemBuilder: (context, pagePosition) {
                          return Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(30)),
                                ),
                                clipBehavior: Clip.hardEdge,
                                child: Image.network(
                                  images[pagePosition],
                                  fit: BoxFit.cover,
                                  width: double.infinity, // Ajusta a imagem
                                ),
                              ),
                              IconButton(
                                icon: const DecoratedIcon(
                                    icon: Icon(
                                      Icons.close,
                                      color: Color.fromARGB(255, 243, 243, 243)
                                    ),
                                    decoration: IconDecoration(border: IconBorder(width: 1.5)),),
                                padding: const EdgeInsets.only(top: 10, right: 10),
                                iconSize: 36,
                                
                                onPressed: () {
                                  Navigator.pop(
                                      context); // Retorna para a tela anterior
                                },
                              )
                            ],
                          );
                        },
                      )
                    : const Center(
                        child: Text(
                            'Sem imagens disponíveis'),), // Se não houver imagens
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  margin: const EdgeInsets.only(top: 10),
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
          
          ListTile(
            title: Text(widget.pico.picoName),
          ),
          ListTile(
            title: Text('Nota'),
            subtitle: Text('Nota: ${widget.pico.nota.toString()}'),
          ),
          ListTile(
            title: Text('Modalidade'),
            subtitle: Text(widget.pico.modalidade),
          ),
          ListTile(
            title: Text('Tipo do Pico'),
            subtitle: Text(widget.pico.tipoPico),
          ),
        ],
      ),
    );
  }
}
