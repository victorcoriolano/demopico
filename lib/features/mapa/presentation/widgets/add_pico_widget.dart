import 'package:demopico/core/common/inject_dependencies.dart';
import 'package:demopico/features/mapa/domain/entities/pico_entity.dart';
import 'package:demopico/features/mapa/presentation/controllers/spot_controller.dart';
import 'package:flutter/material.dart';

import 'add_pico_modal/primeira_tela.dart';

class AddPicoWidget extends StatelessWidget {
  const AddPicoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 40.0, // Distância do fundo da tela
      right: 20.0, // Distância da borda direita da tela
      child: Container(
        width: 72, // Tamanho total do Container
        height: 72, // Tamanho total do Container
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.transparent, // Cor de fundo do Container
          border: Border.all(
            color: const Color.fromARGB(255, 162, 162, 162), // Cor da borda
            width: 2, // Largura da borda
          ),
        ),
        child: Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white, // Cor de fundo
              elevation: 6, // Remove a sombra
              shape: const CircleBorder(), // Forma circular
              padding: EdgeInsets.zero, // Remove o padding padrão
            ),
            onPressed: () {
              // Função de exemplo
              showDialog(
    context: context,
    builder: (BuildContext context) => Dialog.fullscreen(
      child:  // Ocupa toda a altura

       EspecificidadeScreen(), // Mostra a tela dentro do diálogo
      
    ),
  );
            },
            child: SizedBox.expand(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16.0)),
                      color:  Color(0xFFBB271A),
                      // Cor da linha
                    ),
                    width: 44, // Largura da linha horizontal
                    height: 8, // Espessura da linha horizontal
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16.0)),
                      color: Color(0xFFBB271A),
                    ),
                    width: 8, // Espessura da linha vertical
                    height: 44, // Altura da linha vertical
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  // simulação de criação do pico so pra ver se tpa funfando o firebase service 
  void createPico() {
    final pico =       Pico(
      0, 
      0, 
      long: -46.9400143, 
      lat: -23.548546, 
      description: "exemplo",
          atributos:{ "Chão": 5, "Iluminação": 3.5, 'Policiamento': 4, 'Movimento': 2, 'KickOut': 5 },
      fotoPico: null, 
      obstaculos: ['corrimão', 'miniramp'], 
      utilidades: ['agua', 'banheiro'], 
      userCreator: "fulano de tal", 
      urlIdPico: '', 
      picoName: 'picoName');
    final instanciaGetIt = serviceLocator<SpotController>();

    instanciaGetIt.createSpot(pico);
  }
}
