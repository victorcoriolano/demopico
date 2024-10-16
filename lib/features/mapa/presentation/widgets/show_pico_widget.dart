import 'package:demopico/features/mapa/domain/entities/pico_entity.dart';
import 'package:demopico/features/mapa/domain/interfaces/spot_repository.dart';
import 'package:demopico/features/mapa/domain/use%20cases/show_all_pico.dart';
import 'package:flutter/material.dart';

class ShowPicoWidget extends StatefulWidget {
  final Pico pico; 
  
  const ShowPicoWidget({super.key, required this.pico});

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
    return DraggableScrollableSheet(
      initialChildSize: 0.2, // 
      minChildSize: 0.0, 
      maxChildSize: 0.95, 
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
                    child: images.isNotEmpty
                        ? PageView.builder(
                            itemCount: images.length,
                            pageSnapping: true,
                            itemBuilder: (context, pagePosition) {
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(30)),
                                ),
                                clipBehavior: Clip.hardEdge,
                                child: Image.network(
                                  images[pagePosition],
                                  fit: BoxFit.cover, // Ajusta a imagem
                                ),
                              );
                            },
                          )
                        : Center(child: Text('Sem imagens disponíveis')), // Se não houver imagens
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
      },
    );
  }
}
