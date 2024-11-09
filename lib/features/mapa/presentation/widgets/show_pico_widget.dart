import 'package:demopico/features/mapa/domain/entities/pico_entity.dart';
import 'package:flutter/material.dart';
import 'package:icon_decoration/icon_decoration.dart';
//import 'package:flutter/src/rendering/box.dart';

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
      child: Column(
        children: [
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
                                  icon: Icon(Icons.close,
                                      color:
                                          Color.fromARGB(255, 243, 243, 243)),
                                  decoration: IconDecoration(
                                      border: IconBorder(width: 1.5)),
                                ),
                                padding:
                                    const EdgeInsets.only(top: 10, right: 10),
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
                        child: Text('Sem imagens disponíveis'),
                      ), // Se não houver imagens
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
          Expanded(
            child: ListView(
              controller: widget.scrollController,
              children: [
                // Barra de arrastar

                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: List.generate(
                                widget.pico.obstaculos!.length, (index) {
                              return Icon(Icons.square,
                                  color: index < 3 ? Colors.blue : Colors.grey);
                            }),
                          ),
                          // Avaliação com estrelas
                          Row(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    widget.pico.nota.toString(),
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(width: 8),
                                  Row(
                                    children: List.generate(5, (index) {
                                      if (index < widget.pico.nota!.floor()) {
                                        // Estrela cheia
                                        return Icon(Icons.star,
                                            color: Colors.black);
                                      } else if (index ==
                                              widget.pico.nota!.floor() &&
                                          (widget.pico.nota! % 1) >= 0.5) {
                                        // Meia estrela se a parte decimal for >= 0.5
                                        return Icon(Icons.star_half,
                                            color: Colors.black);
                                      } else {
                                        // Estrela vazia
                                        return Icon(Icons.star,
                                            color: Colors.grey);
                                      }
                                    }),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 16),

                      // Informações do local e descrição
                      Row(
                        children: [
                          const CircleAvatar(
                            radius: 25,
                            child: Icon(
                              Icons.person,
                              size: 35,
                            ),
                          ),
                          SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.pico.picoName.toUpperCase(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Text(
                                "Devsk8",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 15),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 16),

                      // Comentário
                      Text(
                        widget.pico.description ?? '',
                        style: TextStyle(color: Colors.red, fontSize: 14),
                      ),
                      SizedBox(height: 16),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF8B0000),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 7),
                            ),
                            onPressed: () {},
                            child: Text(
                              "ABRIR DISCUSSÃO",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                  ' ${widget.pico.numeroAvaliacoes.toString()} avaliações',
                                  style: TextStyle(
                                      color:
                                          const Color.fromARGB(255, 93, 93, 93),
                                      fontSize: 12)),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.thumb_up),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.thumb_down),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 16),

                      // Ícones à direita (salvar, sinalizar, etc.)
                      Align(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.bookmark_border),
                              iconSize: 30,
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.flag),
                                iconSize: 30),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.navigation),
                                iconSize: 30),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
