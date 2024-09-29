import 'package:flutter/material.dart';
import 'quarta_tela.dart';

class TerceiraTela extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Obtém a altura da tela
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      // Cor de fundo da tela
      backgroundColor: Color.fromRGBO(238, 238, 238, 1),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Padding em torno do contêiner
          child: Container(
            // Estilo do contêiner
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12), // Bordas arredondadas
              color: Colors.white, // Cor de fundo para o contêiner
              border: Border.all(color: Color(0xFF8B0000), width: 3), // Borda vermelha (mesma cor dos botões)
            ),
            child: SingleChildScrollView( // Permite rolagem se o conteúdo for muito grande
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center, // Centraliza o conteúdo na coluna
                children: [
                  // Imagem do topo
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 20.0), // Espaçamento acima e abaixo da imagem
                    child: Image.asset(
                      'lib/assets/addPico3.png', // Caminho da imagem
                      height: screenHeight * 0.2, // Altura da imagem como 20% da altura da tela
                    ),
                  ),
                  // Título da seção
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0), // Espaçamento vertical para o título
                    child: Text(
                      'OBSTÁCULOS', // Texto do título
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black), // Estilo do texto
                    ),
                  ),
                  // Container para o Grid de obstáculos
                  Container(
                    height: screenHeight * 0.5, // Altura fixa do contêiner do Grid
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5, // Número de caixas por linha
                        mainAxisSpacing: 6, // Espaçamento entre linhas
                        crossAxisSpacing: 6, // Espaçamento entre colunas
                        childAspectRatio: 1.0, // Faz as caixas serem quadradas
                      ),
                      itemCount: 15, // Total de 15 caixas
                      itemBuilder: (context, index) {
                        return Container(
                          height: 20, // Altura das caixas
                          padding: EdgeInsets.all(0), // Sem padding
                          decoration: BoxDecoration(
                            color: Colors.brown[400], // Cor das caixas
                          ),
                        );
                      },
                    ),
                  ),
                  // Botão de voltar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center, // Centraliza os botões
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF8B0000), // Cor do botão "VOLTAR"
                          foregroundColor: Colors.white, // Cor do texto do botão
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15), // Padding do botão
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), // Bordas arredondadas
                        ),
                        onPressed: () {
                          Navigator.pop(context); // Voltar para a tela anterior
                        },
                        child: Text('VOLTAR', style: TextStyle(fontSize: 15)), // Texto do botão
                      ),
                    ],
                  ),
                  SizedBox(height: 10), // Espaço de 10 pixels entre os botões
                  // Botão de prosseguir
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0), // Adiciona um padding embaixo do botão
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center, // Centraliza os botões
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF8B0000), // Cor do botão "PROSSEGUIR"
                            foregroundColor: Colors.white, // Cor do texto do botão
                            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15), // Padding do botão
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), // Bordas arredondadas
                          ),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => QuartaTela())); // Navega para a QuartaTela
                          },
                          child: Text('PROSSEGUIR', style: TextStyle(fontSize: 15)), // Texto do botão
                        ),
                      ],
                    ),
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
