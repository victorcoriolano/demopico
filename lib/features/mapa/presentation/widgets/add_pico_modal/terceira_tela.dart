import 'package:demopico/features/mapa/presentation/controllers/add_pico_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TerceiraTela extends StatelessWidget {
  const TerceiraTela({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtém a altura da tela
    final screenHeight = MediaQuery.of(context).size.height;
    final listaObstaculos = ["Lixeira", "Hidrante", "Corrimão", "Parede",
              "Spine", "Funbox", "Pirâmide", "Stepper", "Quarter",
              "Transição", "Megaramp", "Miniramp", "Escada", "Jump",
              "Barreira newjersey", "45° graus", "Gap", "Bowl zinho", 
              "Bowl zão", "Banco"];

    final listaIcon = [
      Icons.delete_outline_sharp, //icons para lixeira
      Icons.fire_hydrant_alt_sharp, // icon para o hidrante
   Icons.skateboarding, 
      Icons.skateboarding, 
      Icons.skateboarding, 
      Icons.skateboarding, 
      Icons.skateboarding, 
      Icons.skateboarding, 
      Icons.skateboarding, 
      Icons.skateboarding, 
      Icons.skateboarding, 
      Icons.skateboarding, 
      Icons.skateboarding, 
      Icons.skateboarding, 
      Icons.skateboarding, 
      Icons.skateboarding, 
      Icons.skateboarding, 
      Icons.skateboarding, 
      Icons.skateboarding, 
      Icons.skateboarding, 
    ];
 

    return Consumer<AddPicoControllerProvider>(
      builder: (context, provider, child) => 
      Scaffold(
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
                  height: screenHeight * 0.5, // Altura fixa do contêiner do Grid
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5, // Número de caixas por linha
                      mainAxisSpacing: 6, // Espaçamento entre linhas
                      crossAxisSpacing: 6, // Espaçamento entre colunas
                      childAspectRatio: 1.0, // Faz as caixas serem quadradas
                    ),
                    itemCount: listaObstaculos.length, // Total de 15 caixas
                    itemBuilder: (context, index) {
                      return 
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Container(
                            height: 20, // Altura das caixas
                            padding: const EdgeInsets.all(0), // Sem padding
                            child: IconButton(
                              color: const Color.fromARGB(255, 45, 45, 45),
                              iconSize: 36,
                              icon: Icon(listaIcon[index],), 
                              //mostra os icones dos respectivos obstáculos 
                              onPressed: () {
                                // se tiver na lista remove se não tiver adiciona
                                if(provider.obstaculos.contains(listaObstaculos[index])){
                                  provider.obstaculos.remove(listaObstaculos[index]);
                                }else{
                                  provider.atualizarObstaculos(listaObstaculos[index]);
                                }
                                print(provider.obstaculos);
                              },
                            ),
                          ),
                        
                      );
                    },
                  ),
                ),
                // Botão de voltar
      
                const SizedBox(height: 10), // Espaço de 10 pixels entre os botões
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
