import 'package:demopico/features/mapa/presentation/controllers/add_pico_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Classe que representa a quarta tela
class QuartaTela extends StatefulWidget {
  const QuartaTela({super.key});

  @override
  State<QuartaTela> createState() => _QuartaTelaState();
}

class _QuartaTelaState extends State<QuartaTela> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AddPicoProvider>(
      builder: (context, provider, child) => Scaffold(
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
                const SizedBox(height: 10),
                // Campo de texto para o nome do pico
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Escreva aqui...', // Texto de sugestão
                    border: const OutlineInputBorder(), // Borda do campo
                    errorText: provider.errors,
                  ),
                  onChanged: (value) => provider.atualizarNome(value),
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
                const SizedBox(height: 10),
                // Campo de texto para a descrição do pico
                TextFormField(
                  maxLines: 5, // Permite múltiplas linhas
                  decoration: InputDecoration(
                    hintText: 'Escreva aqui...', // Texto de sugestão
                    border: const OutlineInputBorder(), // Borda do campo
                    errorText: provider.errors,
                  ),
                  onChanged: (value) => provider.atualizarDescricao(value),
                ),
                const SizedBox(height: 20), // Espaço entre os campos
                // Botão para anexar imagens
                GestureDetector(
                  onTap: () async {
                    // Função para anexar imagem (placeholder)
                    if (provider.files.length <= 3) {
                      await provider.pickImages();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Só é possível anexar no máximo 3 imagens.'),
                        ),
                      );
                    }
                    
                  },
                  child: Column(
                    children: [
                       Icon(Icons.cloud_upload,
                          size: 62, color: provider.files.length <=3 ? Colors.black : Colors.grey), // Ícone de upload
                      const Text(
                        'ANEXAR IMAGENS',
                        style: TextStyle(fontSize: 16), // Texto abaixo do ícone
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 5),
                        child: Visibility(
                          visible: provider.files.isNotEmpty,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 120,
                                child: ListView.separated(
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(width: 10),
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount: provider.files.length,
                                    itemBuilder: (context, index) {
                                      return Stack(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              
                                            ),
                                            width: 90,
                                            child: Image.memory(
                                              provider.files[index].bytes,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Positioned(
                                            top: 0,
                                            right: 0,
                                            child: IconButton(
                                              onPressed: () {
                                                provider
                                                  .files
                                                  .removeAt(index);
                                                setState(() {});
                                              },   
                                              icon: const Icon(Icons.close),
                                            ),
                                          ),
                                          const Positioned(
                                            bottom: 0,
                                            child: Icon(Icons.check_circle, color: Colors.green,),
                                          ),
                                        ],
                                      );
                                    }),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
