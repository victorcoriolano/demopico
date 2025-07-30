import 'dart:math';

import 'package:demopico/core/app/auth_wrapper.dart';
import 'package:demopico/core/app/theme/theme.dart';
import 'package:demopico/features/denunciar/widgets/denunciar_widget.dart';
import 'package:demopico/features/denunciar/denuncia_model.dart';
import 'package:demopico/features/mapa/domain/entities/pico_entity.dart';
import 'package:demopico/features/mapa/domain/entities/pico_favorito.dart';
import 'package:demopico/features/mapa/presentation/controllers/spot_provider.dart';
import 'package:demopico/features/mapa/presentation/controllers/spots_controller.dart';
import 'package:demopico/features/mapa/presentation/controllers/favorite_spot_controller.dart';
import 'package:demopico/features/mapa/presentation/pages/comment_page.dart';
import 'package:demopico/features/mapa/presentation/view_services/modal_helper.dart';
import 'package:demopico/features/user/presentation/controllers/user_database_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:provider/provider.dart';

class ShowPicoWidget extends StatefulWidget {
  final String idPico;
  final void Function(Pico) deletarPico;

  const ShowPicoWidget({
    super.key,
    required this.deletarPico,
    required this.idPico,
  });

  @override
  State<ShowPicoWidget> createState() => _ShowPicoWidgetState();
}

int _currentPage = 0;

class _ShowPicoWidgetState extends State<ShowPicoWidget> {
  final Map<String, String> obstaculosMap = {
    "45° graus": "assets/images/icons/45graus.png",
    "Barreira newjersey": "assets/images/icons/barreira.png",
    "Bowl zão": "assets/images/icons/bowl.png",
    "Banco": "assets/images/icons/cadeira.png",
    "Corrimão": "assets/images/icons/corrimao.png",
    "Escada": "assets/images/icons/escada.png",
    "Funbox": "assets/images/icons/funbox.png",
    "Gap": "assets/images/icons/gap.png",
    "Jump": "assets/images/icons/jump.png",
    "Megaramp": "assets/images/icons/megaramp.png",
    "Miniramp": "assets/images/icons/miniramp.png",
    "Pirâmide": "assets/images/icons/piramede.png",
    "Quarter": "assets/images/icons/quarter.png",
    "Spine": "assets/images/icons/spine.png",
    "Stepper": "assets/images/icons/stepper.png",
    "Transição": "assets/images/icons/transição.png",
    "Hidrante": "assets/images/icons/hidrante.png",
    "Parede": "assets/images/icons/wallObstaculo.png",
    "Bowl zinho": "assets/images/icons/bowl.png",
    "Lixeira": "assets/images/icons/lixeira.png",
  };

  

  @override
  void dispose() {
    // Resetando o valor de _currentPage antes de fechar a página
    _currentPage = 0;
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) { 
      context.read<SpotProvider>().initializeWatch(widget.idPico);
    });
  }

  bool isMine(){
    final user = context.read<UserDatabaseProvider>().user;
    final pico = context.read<SpotProvider>().pico;

      return user != null && pico != null 
        && pico.userName == user.name;
    }

  @override
  Widget build(BuildContext context) {
    debugPrint("show pico widget");

    return DraggableScrollableSheet(
        initialChildSize: 0.8,
        minChildSize: 0.2,
        maxChildSize: 0.83,
        builder: (BuildContext context, ScrollController scrollController) {
          return Container(
            decoration: const BoxDecoration(
              color: kAlmostWhite,
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
                // widget da imagem dos spots
                
                Expanded(
                  child: ListView(
                    controller: scrollController,
                    children: [
                      // Barra de arrastar
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 200,
                                  child: Wrap(
                                    children: List.generate(
                                        widget.pico.obstaculos.length, (index) {
                                      String obstaculo =
                                          widget.pico.obstaculos[index];
                                      String? iconPath = obstaculosMap[
                                          obstaculo]; // Busca o caminho do ícone no Map

                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal:
                                                4.0), // Ajuste opcional de espaçamento
                                        child: iconPath != null
                                            ? Image.asset(
                                                iconPath,
                                                width: 40, // Largura da imagem
                                                height: 40, // Altura da imagem
                                              )
                                            : const Icon(
                                                Icons
                                                    .error, // Ícone padrão caso o obstáculo não exista no Map
                                                color: Colors.red,
                                              ),
                                      );
                                    }),
                                  ),
                                ),

                                // Avaliação com estrelas
                                SizedBox(
                                  width: 200,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                widget.pico.initialNota
                                                    .toStringAsFixed(2),
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const SizedBox(width: 8),
                                              Row(
                                                children:
                                                    List.generate(5, (index) {
                                                  if (index <
                                                      widget.pico.initialNota
                                                          .floor()) {
                                                    // Estrela cheia
                                                    return const Icon(
                                                        Icons.star,
                                                        color: Colors.black);
                                                  } else if (index ==
                                                          widget.pico.initialNota
                                                              .floor() &&
                                                      (widget.pico.initialNota % 1) >=
                                                          0.5) {
                                                    // Meia estrela se a parte decimal for >= 0.5
                                                    return const Icon(
                                                        Icons.star_half,
                                                        color: Colors.black);
                                                  } else {
                                                    // Estrela vazia
                                                    return const Icon(
                                                        Icons.star,
                                                        color: Colors.grey);
                                                  }
                                                }),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    top: 5),
                                                child: Text(
                                                  ' ${widget.pico.numeroAvaliacoes.toString()} avaliações',
                                                  style: const TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 93, 93, 93),
                                                      fontSize: 12),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),

                            // Informações do local e descrição
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Foto e Nome
                                ConstrainedBox(
                                  constraints: const BoxConstraints(
                                      maxWidth: 80), // Largura máxima definida
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 52,
                                        height: 52,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: const Color.fromARGB(255,
                                                205, 23, 23), // Cor da borda
                                            width: 0.5, // Largura da borda
                                          ),
                                        ),
                                        child: const CircleAvatar(
                                          foregroundColor: Color.fromARGB(
                                              255, 255, 255, 255),
                                          backgroundColor:
                                              Color.fromARGB(255, 169, 41, 41),
                                          radius: 25,
                                          child: Icon(
                                            Icons.person,
                                            size: 38,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        widget.pico.userName ??
                                            "ANÔNIMO", // Nome fixo abaixo da foto
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 93, 93, 93),
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 15),

                                // Nome do local e descrição
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.pico.picoName
                                            .toUpperCase(), // Nome do local
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 19,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        widget.pico.description ??
                                            '', // Descrição do local
                                        style: const TextStyle(
                                          color: Color(0xFF8B0000),
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 25),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF8B0000),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 50,
                                      vertical: 10,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) => CommentPage(
                                          picoId: widget.pico.id,
                                        ),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    "ABRIR DISCUSSÃO",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Column(
                                  children: [
                                    OutlinedButton(
                                      onPressed: () =>
                                          avaliarPico(context, widget.pico),
                                      style: OutlinedButton.styleFrom(
                                        side: const BorderSide(
                                            color: Color(
                                                0xFF8B0000)), // Borda vermelha
                                        backgroundColor:
                                            Colors.white, // Fundo branco
                                      ),
                                      child: const Text(
                                        'AVALIAR PICO',
                                        style: TextStyle(
                                            color: Color(
                                                0xFF8B0000), // Texto vermelho
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(height: 9),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 0,
                                  color: const Color.fromARGB(0, 70, 70, 70),
                                ),
                              ),
                              child: Column(
                                children: [
                                  for (var entry
                                      in widget.pico.atributos.entries)
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 8),
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 4.0),
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
                            Container(
                              margin: const EdgeInsets.only(top: 15),
                              child: Align(
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    IconButton(
                                      onPressed: () async {
                                        if (user == null) {
                                          Navigator.pop(context);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text(
                                                'Você precisa estar logado para salvar um pico!'),
                                              action: SnackBarAction(label: "Fazer Login", onPressed: () {
                                                Get.to((_) => AuthWrapper());
                                              }),  
                                          ));
                                          return;
                                        }

                                        final picoFav = PicoFavorito(
                                            idPico: widget.pico.id,
                                            idUsuario: user.id);
                                        
                                            await provider.savePico(picoFav);
                                        if (provider.error != null) {
                                          if (context.mounted) {
                                            Navigator.pop(context);
                                            
                                            Get.snackbar("Ocorreu um erro ao salvar o Pico", provider.error!);
                                          }
                                        }
                                      },
                                      icon: const Icon(Icons.bookmark_border),
                                      tooltip: "Salvar Pico",
                                      iconSize: 35,
                                    ),
                                    IconButton(
                                        tooltip: "Denunciar Pico",
                                        onPressed: () {
                                          ModalHelper.openReportSpotModal(context, idUser, idPub, type)
                                        },
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
        });
  }
}
