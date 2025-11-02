import 'package:demopico/core/app/theme/theme.dart';
import 'package:demopico/core/common/widgets/image_validator_widget.dart';
import 'package:demopico/features/mapa/presentation/controllers/add_pico_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuartaTela extends StatefulWidget {
  const QuartaTela({super.key});

  @override
  State<QuartaTela> createState() => _QuartaTelaState();
}

class _QuartaTelaState extends State<QuartaTela> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();


  @override
  void initState() {
    super.initState();
    final provider = context.read<AddPicoViewModel>();
    _nameController.text = provider.nomePico;
    _descriptionController.text = provider.descricao;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AddPicoViewModel>(
      builder: (context, provider, child) => Scaffold(
        backgroundColor: Colors.grey[200],
        body: SingleChildScrollView(
            child: Center(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.center, 
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset(
                      'assets/images/progresso4.png',
                    ),
                  ),
                ),
                const SizedBox(height: 20), 
                const Text(
                  'NOME DO PICO:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) =>
                      provider.isFormValid(StepsAddPico.detalhesAdicionais)
                          ? null
                          : provider.nameSpotError,
                  decoration: InputDecoration(
                    hintText: 'Escreva aqui...', // Texto de sugestão
                    border: const OutlineInputBorder(), // Borda do campo
                    errorText: provider.nameSpotError,
                  ),
                  controller: _nameController,
                  onChanged: (value) => provider.nomePico = value,
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
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) =>
                      provider.isFormValid(StepsAddPico.detalhesAdicionais)
                          ? null
                          : provider.descriptionError,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: 'Escreva aqui...',
                    border: const OutlineInputBorder(),
                    errorText: provider.descriptionError,
                  ),
                  controller: _descriptionController,
                  onChanged: (value) => provider.descricao = value,
                ),
                const SizedBox(height: 20),
              Visibility(
                  visible: provider.isLoading,
                  child:  ImageValidatorWidget()),
                // Botão para anexar imagens
                Visibility(
                  visible: provider.files.length <= 3 && provider.isLoading == false,
                  child: GestureDetector(
                    onTap:  provider.files.length <= 3
                        ? ()  async => provider.pickImages() 
                        : null,
                    child: const Column(
                      children: [
                        Icon(Icons.cloud_upload,
                            size: 62, color: Colors.black), // Ícone de upload
                        Text(
                          'ANEXAR IMAGENS',
                          style:
                              TextStyle(fontSize: 16), // Texto abaixo do ícone
                        ),
                      ],
                    ),
                  ),
                ),
                  
                Visibility(
                  visible: provider.files.isNotEmpty,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 150,
                        child: ListView.separated(
                            padding: EdgeInsets.all(8.0),
                            separatorBuilder: (context, index) =>
                                const SizedBox(width: 10),
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: provider.files.length,
                            itemBuilder: (context, index) {
                              return Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Container(
                                    width: 120,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      image: DecorationImage(
                                        image: MemoryImage(
                                            provider.files[index].bytes),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  
                                  Positioned(
                                    top: -10,
                                    right: -10,
                                    child: CircleAvatar(
                                      backgroundColor: kRed,
                                      radius: 16,
                                      child: IconButton(
                                        padding: EdgeInsets.zero,
                                        constraints: const BoxConstraints(),
                                        onPressed: () =>
                                            provider.removerImagens(
                                                provider.files[index]),
                                        icon: const Icon(
                                          Icons.close,
                                          color: kWhite,
                                          size: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }),
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
