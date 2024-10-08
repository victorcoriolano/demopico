import 'package:flutter/material.dart';
import 'quarta_tela.dart';

class TerceiraTela extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Obtém a altura da tela
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      // Cor de fundo da tela
     backgroundColor: Colors.grey[200],
      body: Center(
      
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
                        return Padding(
                          padding: EdgeInsets.all(14),
                          child: Container(
                            height: 20, // Altura das caixas
                            padding: EdgeInsets.all(0), // Sem padding
                            decoration: BoxDecoration(
                              color: Colors.brown[400], // Cor das caixas
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  // Botão de voltar
                  
                  SizedBox(height: 10), // Espaço de 10 pixels entre os botões
                  // Botão de prosseguir
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0), // Adiciona um padding embaixo do botão
                    
                  ),
                ],
              ),
            ),
          ),
       

    );
  }
}
