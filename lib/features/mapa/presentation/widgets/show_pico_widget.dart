import 'package:demopico/features/mapa/domain/entities/pico_entity.dart';
import 'package:demopico/features/mapa/presentation/controllers/spot_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:provider/provider.dart';
//import 'package:flutter/src/rendering/box.dart';

class ShowPicoWidget extends StatefulWidget {
  final Pico pico;
  final ScrollController scrollController;
  final Map<String, int>? atributos;

  const ShowPicoWidget(
      {super.key,
      required this.pico,
      required this.scrollController,
      this.atributos});

  @override
  State<ShowPicoWidget> createState() => _ShowPicoWidgetState();
}

int _currentPage = 0;

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

  Widget buildAttributeIcons(int value) {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      Row(
        children: [
          // Gerando 5 ícones
          ...List.generate(5, (index) {
            return Image.asset(
              'assets/images/iconPico.png',
              color: index < value
                  ? const Color.fromARGB(255, 169, 41, 41)
                  : Colors.grey,
              width: 28,
            );
          }),
          // Adicionando o texto
          // Substitua por qualquer texto ou valor desejado
        ],
      ),
      Text('Algum texto aqui'),
    ]);
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
              SizedBox(
                width: double.infinity,
                height: 300, // Altura ajustada para incluir o indicador
                child: images.isNotEmpty
                    ? Stack(
                        children: [
                          PageView.builder(
                            itemCount: images.length,
                            onPageChanged: (int page) {
                              setState(() {
                                _currentPage = page; // Atualiza a página atual
                              });
                            },
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
                                      width: double.infinity,
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.close,
                                      color: Color.fromARGB(255, 243, 243, 243),
                                    ),
                                    padding: const EdgeInsets.only(
                                        top: 10, right: 10),
                                    iconSize: 36,
                                    onPressed: () {
                                      Navigator.pop(
                                          context); // Retorna para a tela anterior
                                    },
                                  )
                                ],
                              );
                            },
                          ),
                          Positioned(
                            bottom: 10, // Posição do indicador
                            left: 0,
                            right: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(images.length, (index) {
                                return Container(
                                  margin: EdgeInsets.symmetric(horizontal: 5),
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 4),
                                    width: _currentPage == index ? 12 : 8,
                                    height: _currentPage == index ? 12 : 8,
                                    decoration: BoxDecoration(
                                      color: _currentPage == index
                                          ? Colors.white
                                          : Colors.white54,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                        ],
                      )
                    : const Center(
                        child: Text('Sem imagens disponíveis'),
                      ),
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
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
                                    widget.pico.nota!.toStringAsFixed(2),
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(width: 8),
                                  Row(
                                    children: List.generate(5, (index) {
                                      if (index < widget.pico.nota!.floor()) {
                                        // Estrela cheia
                                        return const Icon(Icons.star,
                                            color: Colors.black);
                                      } else if (index ==
                                              widget.pico.nota!.floor() &&
                                          (widget.pico.nota! % 1) >= 0.5) {
                                        // Meia estrela se a parte decimal for >= 0.5
                                        return const Icon(Icons.star_half,
                                            color: Colors.black);
                                      } else {
                                        // Estrela vazia
                                        return const Icon(Icons.star,
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
                      const SizedBox(height: 16),

                      // Informações do local e descrição
                      Row(
                        children: [
                          Container(
                            width: 52,
                            height: 52,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color.fromARGB(
                                    255, 205, 23, 23), // Cor da borda
                                width: 0.5, // Largura da borda
                              ),
                            ),
                            child: const CircleAvatar(
                              foregroundColor:
                                  Color.fromARGB(255, 255, 255, 255),
                              backgroundColor: Color.fromARGB(255, 169, 41, 41),
                              radius: 25,
                              child: Icon(
                                Icons.person,
                                size: 38,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.pico.picoName.toUpperCase(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              const Text(
                                "Devsk8",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 16),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Comentário
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          widget.pico.description ?? '',
                          style: const TextStyle(
                              color: Color(0xFF8B0000),
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 16),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF8B0000),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 7),
                            ),
                            onPressed: () {},
                            child: const Text(
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
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 93, 93, 93),
                                    fontSize: 12),
                              ),
                              TextButton(
                                onPressed: () =>
                                    avaliarPico(context, widget.pico),
                                child: const Text('Avaliar pico'),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 2,
                              color: const Color.fromARGB(216, 0, 0, 0)),
                        ),
                        child: Column(
                          children: [
                            for (var entry in widget.pico.atributos!.entries)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 25),
                                margin:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                // Adicionando margem se necessário
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${entry.key.toUpperCase()}: ",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                      buildAttributeIcons(entry.value),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      // Ícones à direita (salvar, sinalizar, etc.)
                      Container(
                        margin: EdgeInsets.only(top: 15),
                        child: Align(
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.bookmark_border),
                                iconSize: 35,
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.flag),
                                  iconSize: 35),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.share_rounded),
                                  iconSize: 35),
                            ],
                          ),
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

  Future<void> avaliarPico(BuildContext context, Pico pico) async {
    double nota = 0;
    String mensagem = "";
    final provider = context.read<SpotControllerProvider>();

    await showDialog(
      context: context,
      builder: (
        context,
      ) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: const Text("Avaliar Pico"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(mensagem),
                SizedBox(height: 10),
                RatingBar.builder(
                  initialRating: 0,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    setState(() {
                      nota = rating; // Atualiza a nota com base no índice
                      mensagem = getMensagemPico(nota);
                    });
                  },
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Cancelar"),
              ),
              TextButton(
                onPressed: () async {
                  await provider.avaliarPico(pico, nota);
                  Navigator.of(context).pop();
                },
                child: const Text("Avaliar"),
              ),
            ],
          );
        });
      },
    );
  }

  String getMensagemPico(double nota) {
    if (nota >= 4.0) {
      return "Pico muito marreta!";
    } else if (nota >= 2.5) {
      return "Pico marretinha!";
    } else {
      return "Pico legal!";
    }
  }
}
