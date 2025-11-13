import 'package:demopico/core/app/theme/theme.dart';
import 'package:demopico/features/mapa/presentation/controllers/add_pico_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TerceiraTela extends StatelessWidget {
  const TerceiraTela({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtém a altura da tela
    final screenHeight = MediaQuery.of(context).size.height;

    final List<String> listaIcon = [
      "assets/images/icons/45graus.png", // 45° graus
      "assets/images/icons/barreira.png", // Barreira newjersey
      "assets/images/icons/bowl.png", // Bowl zão
      "assets/images/icons/cadeira.png", // Banco
      "assets/images/icons/corrimao.png", // Corrimão
      "assets/images/icons/escada.png", // Escada
      "assets/images/icons/funbox.png", // Funbox
      "assets/images/icons/gap.png", // Gap
      "assets/images/icons/jump.png", // Jump
      "assets/images/icons/megaramp.png", // Megaramp
      "assets/images/icons/miniramp.png", // Miniramp
      "assets/images/icons/piramede.png", // Pirâmide
      "assets/images/icons/quarter.png", // Quarter
      "assets/images/icons/spine.png", // Spine
      "assets/images/icons/stepper.png", // Stepper
      "assets/images/icons/transição.png", // Transição
      "assets/images/icons/hidrante.png", // Hidrante
      "assets/images/icons/wallObstaculo.png", // Parede
      "assets/images/icons/bowl.png", // Bowl zinho
      "assets/images/icons/lixeira.png", //Lixeira
      "assets/images/icons/icone21.png",
      "assets/images/icons/icone22.png",
      "assets/images/icons/icone23.png",
      "assets/images/icons/icone24.png",
      "assets/images/icons/icone25.png",
      "assets/images/icons/icone26.png",
      "assets/images/icons/icone27.png",
      "assets/images/icons/icone28.png",
      "assets/images/icons/icone29.png",
      "assets/images/icons/icone30.png",
      "assets/images/icons/icone31.png",
      "assets/images/icons/icone32.png",
      "assets/images/icons/icone33.png",
      "assets/images/icons/icone34.png",
    ];

    return Consumer<AddPicoViewModel>(
      builder: (context, provider, child) => Scaffold(
        // Cor de fundo da tela
        backgroundColor: Colors.grey[200],
        body: Center(
          child: SingleChildScrollView(
            // Permite rolagem se o conteúdo for muito grande
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.center, // Centraliza o conteúdo na coluna
              children: [
                // Título da seção
                const Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 20.0), // Espaçamento vertical para o título
                  child: Text(
                    'OBSTÁCULOS', // Texto do título
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: kRed), // Estilo do texto
                  ),
                ),
                // conteiner pra demostrar os obstáculos selecionados
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Visibility(
                    visible: provider.obstaculoVo.selectedValues.isNotEmpty,
                    child: Wrap(
                      spacing: 6,
                      runSpacing: 3,
                      children:
                          provider.obstaculoVo.selectedValues.map((obstaculo) {
                        return Chip(
                          deleteIconColor: const Color.fromARGB(255, 255, 255, 255),
                          label: Text(obstaculo),
                          labelStyle: TextStyle(color: kWhite),
                          backgroundColor:
                              kRed,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(
                              color: kRed, // cor da borda
                              width: 2, // espessura
                            ),
                          ),
                          onDeleted: () {
                            provider.removeObstacle(obstaculo);
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ),
                // Container para o Grid de obstáculos
                SizedBox(
                  height:
                      screenHeight * 0.5, // Altura fixa do contêiner do Grid
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5, // Número de caixas por linha
                      mainAxisSpacing: 6, // Espaçamento entre linhas
                      crossAxisSpacing: 6, // Espaçamento entre colunas
                      childAspectRatio: 1.0, // Faz as caixas serem quadradas
                    ),
                    itemCount: provider
                        .obstaculoVo.options.length, // Total de 15 caixas
                    itemBuilder: (context, index) {
                      if (provider.obstaculoVo.options.isEmpty) {
                        return const Center(
                            child: Text("Nenhum obstáculo disponível"));
                      }

                      final obstacle =
                          provider.obstaculoVo.options.elementAt(index);
                      final options = provider.obstaculoVo.options;
                      final selectedObstacles = provider.obstaculoVo.obstacles;
                      return Padding(
                        padding: const EdgeInsets.all(5),
                        child: Container(
                          height: 20, // Altura das caixas
                          padding: const EdgeInsets.all(0), // Sem padding
                          child: InkWell(
                            onTap: () {
                              // Se estiver na lista, remove; caso contrário, adiciona
                              if (selectedObstacles.contains(options[index])) {
                                provider.removeObstacle(obstacle);
                              } else {
                                provider.selectObstacle(obstacle, context);
                              }
                            },
                            child: Image.asset(
                              listaIcon[index],
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
