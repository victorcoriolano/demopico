import 'package:flutter/material.dart';

// Classe que representa a quarta tela
class QuartaTela extends StatelessWidget {
  const QuartaTela({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200], // Cor de fundo da tela
      body: SingleChildScrollView( // Permite rolagem do conteúdo
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0), // Padding em torno do contêiner
            child: Container(
              width: 350, // Largura fixa do contêiner
              padding: const EdgeInsets.all(16), // Padding interno do contêiner
              decoration: BoxDecoration(
                color: Colors.white, // Cor de fundo do contêiner
                borderRadius: BorderRadius.circular(12), // Bordas arredondadas
                border: Border.all(color: Color(0xFF8B0000), width: 3), // Borda na mesma cor dos botões
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center, // Centraliza o conteúdo na coluna
                children: [
                  // Exibir imagem do topo
                  Image.asset('lib/assets/addPico4.png', height: 100),
                  const SizedBox(height: 20), // Espaço entre a imagem e o texto
                  // Texto para o campo de entrada do nome do pico
                  const Text(
                    'NOME DO PICO:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  // Campo de texto para o nome do pico
                  const TextField(
                    decoration: InputDecoration(
                      hintText: 'Escreva aqui...', // Texto de sugestão
                      border: OutlineInputBorder(), // Borda do campo
                    ),
                  ),
                  const SizedBox(height: 20), // Espaço entre os campos
                  // Texto para o campo de descrição
                  const Text(
                    'FALE UM POUCO SOBRE:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  // Campo de texto para a descrição do pico
                  const TextField(
                    maxLines: 5, // Permite múltiplas linhas
                    decoration: InputDecoration(
                      hintText: 'Escreva aqui...', // Texto de sugestão
                      border: OutlineInputBorder(), // Borda do campo
                    ),
                  ),
                  const SizedBox(height: 20), // Espaço entre os campos
                  // Botão para anexar imagens
                  GestureDetector(
                    onTap: () {
                      // Função para anexar imagem (placeholder)
                      print("Anexar imagens");
                    },
                    child: const Column(
                      children: [
                        Icon(Icons.cloud_upload, size: 50, color: Colors.black), // Ícone de upload
                        Text('ANEXAR IMAGENS', style: TextStyle(fontSize: 16)), // Texto abaixo do ícone
                      ],
                    ),
                  ),
                  const SizedBox(height: 20), // Espaço entre o botão de anexar e os outros botões
                  // Botão de voltar
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8B0000), // Cor do botão de voltar
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15), // Padding do botão
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // Bordas arredondadas
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context); // Função para voltar à tela anterior
                    },
                    child: const Text('VOLTAR', style: TextStyle(fontSize: 16)), // Texto do botão
                  ),
                  const SizedBox(height: 20), // Espaço entre os botões
                  // Botão para adicionar pico
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF8B0000), // Cor do botão
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15), // Padding do botão
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // Bordas arredondadas
                      ),
                    ),
                    onPressed: () {
                      // Função para adicionar pico (placeholder)
                      print("Pico adicionado");
                    },
                    child: Text('ADICIONAR PICO', style: TextStyle(fontSize: 16)), // Texto do botão
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
