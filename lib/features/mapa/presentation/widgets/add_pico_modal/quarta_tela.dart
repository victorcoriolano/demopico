import 'package:flutter/material.dart';

// Ponto de entrada da aplicação
void main() {
  runApp(QuartaTelaApp());
}

// Classe principal da aplicação
class QuartaTelaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Adicionar Pico', // Título da aplicação
      theme: ThemeData(
        primaryColor: Colors.red, // Cor principal da tela
      ),
      home: QuartaTela(), // Página inicial da aplicação
    );
  }
}

// Classe que representa a quarta tela
class QuartaTela extends StatelessWidget {
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
              padding: EdgeInsets.all(16), // Padding interno do contêiner
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
                  SizedBox(height: 20), // Espaço entre a imagem e o texto
                  // Texto para o campo de entrada do nome do pico
                  Text(
                    'NOME DO PICO:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  // Campo de texto para o nome do pico
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Escreva aqui...', // Texto de sugestão
                      border: OutlineInputBorder(), // Borda do campo
                    ),
                  ),
                  SizedBox(height: 20), // Espaço entre os campos
                  // Texto para o campo de descrição
                  Text(
                    'FALE UM POUCO SOBRE:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  // Campo de texto para a descrição do pico
                  TextField(
                    maxLines: 5, // Permite múltiplas linhas
                    decoration: InputDecoration(
                      hintText: 'Escreva aqui...', // Texto de sugestão
                      border: OutlineInputBorder(), // Borda do campo
                    ),
                  ),
                  SizedBox(height: 20), // Espaço entre os campos
                  // Botão para anexar imagens
                  GestureDetector(
                    onTap: () {
                      // Função para anexar imagem (placeholder)
                      print("Anexar imagens");
                    },
                    child: Column(
                      children: [
                        Icon(Icons.cloud_upload, size: 50, color: Colors.black), // Ícone de upload
                        Text('ANEXAR IMAGENS', style: TextStyle(fontSize: 16)), // Texto abaixo do ícone
                      ],
                    ),
                  ),
                  SizedBox(height: 20), // Espaço entre o botão de anexar e os outros botões
                  // Botão de voltar
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF8B0000), // Cor do botão de voltar
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15), // Padding do botão
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // Bordas arredondadas
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context); // Função para voltar à tela anterior
                    },
                    child: Text('VOLTAR', style: TextStyle(fontSize: 16)), // Texto do botão
                  ),
                  SizedBox(height: 20), // Espaço entre os botões
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
