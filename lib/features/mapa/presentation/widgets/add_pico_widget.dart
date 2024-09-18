import 'package:flutter/material.dart';

class AddPicoWidget extends StatelessWidget {
  const AddPicoWidget({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Positioned(
            bottom:40.0, // Distância do fundo da tela
            right: 20.0, // Distância da borda direita da tela
            child: Container(
              width: 75, // Tamanho total do Container
              height: 75, // Tamanho total do Container
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
                  },
                  child: SizedBox.expand(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                         decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(16.0)),
                            color: const Color.fromARGB(255, 139, 0, 0), // Cor da linha
                          ),
                          width: 42, // Largura da linha horizontal
                          height: 8, // Espessura da linha horizontal
                        ),
                        Container(
                           decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(16.0)),
                            color: const Color.fromARGB(255, 139, 0, 0), // Cor da linha
                          ),
                          width: 8, // Espessura da linha vertical
                          height: 42, // Altura da linha vertical
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ); 
  }
}