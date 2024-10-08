import 'package:flutter/material.dart';

// Classe que representa a quarta tela
class QuartaTela extends StatelessWidget {
  const QuartaTela({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        // Permite rolagem do conteúdo
        child: Center(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.center, // Centraliza o conteúdo na coluna
            children: [
              // Exibir imagem do topo
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Image.asset(
                    'assets/images/progresso4.png',
                  ),
                ),
              ),
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
              const SizedBox(height: 50), // Espaço entre os campos
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
                    Icon(Icons.cloud_upload,
                        size: 50, color: Colors.black), // Ícone de upload
                    Text('ANEXAR IMAGENS',
                        style:
                            TextStyle(fontSize: 16)), // Texto abaixo do ícone
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
