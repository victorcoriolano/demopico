import 'package:demopico/features/mapa/presentation/controllers/add_pico_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TerceiraTela extends StatelessWidget {
  const TerceiraTela({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtém a altura da tela
    final screenHeight = MediaQuery.of(context).size.height;
    // TODO: COLOCAR NO DOMÍNIO esta lista
    final List<String> listaObstaculos = [
      "45° graus",
      "Barreira newjersey",
      "Bowl zão",
      "Banco",
      "Corrimão",
      "Escada",
      "Funbox",
      "Gap",
      "Jump",
      "Megaramp",
      "Miniramp",
      "Pirâmide",
      "Quarter",
      "Spine",
      "Stepper",
      "Transição",
      "Hidrante",
      "Parede",
      "Bowl zinho",
    ];

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
    ];

    return Consumer<AddPicoProvider>(
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
                // Imagem do topo
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset(
                      'assets/images/progresso3.png',
                    ),
                  ),
                ),
                // Título da seção
                const Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 20.0), // Espaçamento vertical para o título
                  child: Text(
                    'OBSTÁCULOS', // Texto do título
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black), // Estilo do texto
                  ),
                ),
                // conteiner pra demostrar os obstáculos selecionados
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Visibility(
                    visible: provider.obstaculos.isNotEmpty,
                    child: Wrap(
                      spacing: 6,
                      runSpacing: 3,
                      children: provider.obstaculos.map((obstaculo) {
                        return Chip(
                          label: Text(obstaculo),
                          onDeleted: () {
                            provider.removerObstaculo(obstaculo);
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
                    itemCount: listaObstaculos.length, // Total de 15 caixas
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(5),
                        child: Container(
                          height: 20, // Altura das caixas
                          padding: const EdgeInsets.all(0), // Sem padding
                          child: InkWell(
                            onTap: () {
                              // Se estiver na lista, remove; caso contrário, adiciona
                              if (provider.obstaculos
                                  .contains(listaObstaculos[index])) {
                                provider.obstaculos
                                    .remove(listaObstaculos[index]);
                              } else {
                                provider.atualizarObstaculos(
                                    listaObstaculos[index]);
                              }
                            },
                            child: Image.asset(
                              listaIcon[index], // Garante que é uma string
                              fit: BoxFit.contain, // Ajusta a imagem ao botão
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Botão de voltar

                const SizedBox(
                    height: 10), // Espaço de 10 pixels entre os botões
                // Botão de prosseguir
                const Padding(
                  padding: EdgeInsets.only(
                      bottom: 20.0), // Adiciona um padding embaixo do botão
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
