import 'package:demopico/features/mapa/presentation/controllers/add_pico_controller.dart';
import 'package:demopico/features/user/presentation/widgets/validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Classe que representa a quarta tela
class QuartaTela extends StatefulWidget {

  const QuartaTela({super.key});

  @override
  State<QuartaTela> createState() => _QuartaTelaState();
}

class _QuartaTelaState extends State<QuartaTela> with Validators {
  final _controllerNomePico = TextEditingController();
  final _controllerDescricao = TextEditingController();
  final _keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<AddPicoControllerProvider>(
      builder: (context, provider, child) => 
      Scaffold(
        backgroundColor: Colors.grey[200],
        body: SingleChildScrollView(
          // Permite rolagem do conteúdo
          child: Form(
            key: _keyForm,
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
                  TextFormField(
                    controller: _controllerNomePico,
                    decoration: const InputDecoration(
                      hintText: 'Escreva aqui...', // Texto de sugestão
                      border: OutlineInputBorder(), // Borda do campo
                    ),
                    validator: (value) => isNotEmpty(value),
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
                  TextFormField(
                    controller: _controllerDescricao,
                    maxLines: 5, // Permite múltiplas linhas
                    decoration: const InputDecoration(
                      hintText: 'Escreva aqui...', // Texto de sugestão
                      border: OutlineInputBorder(), // Borda do campo
                    ),
                    validator: (value) => isNotEmpty(value),//validação
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
                        Text(
                          'ANEXAR IMAGENS',
                          style:
                            TextStyle(fontSize: 16),// Texto abaixo do ícone
                        ), 
                      ],
                    ),
                  ),
                  ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF8B0000), // Cor do botão
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 50, 
                              vertical: 15,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),       
                          ),
                          onPressed: () {
                            if(_keyForm.currentState!.validate()){
                              
                            }
                          },
                          child:
                            Text('POSTAR PICO', style: TextStyle(fontSize: 15)),
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
