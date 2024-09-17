import 'package:flutter/material.dart';

class AddPicoWidget extends StatelessWidget {
  const AddPicoWidget({super.key});
  
  @override
  Widget build(BuildContext context) {
    return  Stack(
        children: [
          Positioned(
            bottom: 20.0, // Distância do fundo da tela
            right: 20.0, // Distância da borda direita da tela
            child: Container(
              width: 70, // Tamanho total do Container
              height: 70, // Tamanho total do Container
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent, // Cor de fundo do Container
                border: Border.all(
                  color: Color(0xff343434), // Cor da borda
                  width: 2, // Largura da borda
                ),
              ),
              child: Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // Cor de fundo
                    elevation: 0, // Remove a sombra
                    shape: CircleBorder(), // Forma circular
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
                          width: 40, // Largura da linha horizontal
                          height: 6, // Espessura da linha horizontal
                          color: Color.fromARGB(255, 139, 0, 0), // Cor da linha
                        ),
                        Container(
                          width: 6, // Espessura da linha vertical
                          height: 40, // Altura da linha vertical
                          color: Color.fromARGB(255, 139, 0, 0), // Cor da linha
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
  }
}