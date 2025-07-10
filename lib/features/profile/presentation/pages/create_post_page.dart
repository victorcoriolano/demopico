import 'package:demopico/core/app/home_page.dart';
import 'package:demopico/features/profile/presentation/pages/profile_page.dart';
import 'package:demopico/features/profile/presentation/provider/post_provider.dart';
import 'package:demopico/features/profile/presentation/widgets/create_post_widgets/media_preview_list.dart';
import 'package:demopico/features/profile/presentation/widgets/create_post_widgets/midia_input_card.dart';
import 'package:demopico/features/user/domain/enums/type_post.dart';
import 'package:demopico/features/user/presentation/controllers/user_database_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class CreatePostPage extends StatefulWidget {
  final TypePost typePost;
  const CreatePostPage({super.key, required this.typePost});

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  void _showSpotSelectionDialog(BuildContext context, PostProvider provider) {
    // Simulação de picos disponíveis
    final Map<String, String> availableSpots = {
      'spot123': 'Praça da Matriz',
      'spot456': 'Skatepark do Centro',
      'spot789': 'Rua do Comércio',
    };

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Selecionar Pico'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: availableSpots.entries.map((entry) {
                return RadioListTile<String>(
                  title: Text(entry.value),
                  value: entry.key,
                  groupValue: provider.selectedSpotId,
                  onChanged: (String? value) {
                    provider.selectSpot(value);
                    Navigator.pop(dialogContext);
                  },
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                provider.selectSpot(null); // Opção para desmarcar o pico
                Navigator.pop(dialogContext);
              },
              child: const Text('Nenhum Pico'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.typePost == TypePost.post
              ? "Criar Postagem"
              : "Postar Rec"
        )
      ),
      body: Consumer<PostProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Input para adicionar mídia
                MediaInputCard(
                  onAddMedia: () async {
                    widget.typePost == TypePost.post 
                     ? await provider.getFiles()
                     : await provider.getVideo();
                    if (provider.messageError != null) {
                      Get.snackbar("Erro", provider.messageError!);
                    } 
                    
                  },
                  typePost: widget.typePost,
                ),
                const SizedBox(height: 16),

                // Pré-visualização das mídias adicionadas
                MediaPreviewList(
                  mediaPaths: provider.filesModels,
                  onRemoveMedia: provider.removeMedia,
                ),
                const SizedBox(height: 24),

                // Botão para linkar ao pico no mapa
                ElevatedButton.icon(
                  onPressed: () => _showSpotSelectionDialog(context, provider),
                  icon: const Icon(Icons.location_on),
                  label: Text(
                    provider.selectedSpotId != null
                        ? 'Pico Selecionado: ${provider.selectedSpotId}' 
                        : 'Linkar a um Pico no Mapa',
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Campo de descrição
                TextField(
                  controller: _descriptionController,
                  onChanged: provider.updateDescription,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: 'Descreva sua manobra, dica ou momento...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
                    ),
                    labelText: 'Descrição',
                    alignLabelWithHint: true,
                  ),
                ),
                const SizedBox(height: 32),

                // Botão de Publicar
                ElevatedButton(
                  onPressed: () async {
                    final user = context.read<UserDatabaseProvider>().user;
                    if (user == null) {
                      Get.snackbar(
                        'Erro',
                        'Usuário não encontrado. Por favor, faça login novamente.',
                        snackPosition: SnackPosition.BOTTOM,
                      );
                      Get.to((_) => const HomePage());
                      return;
                    }
                    try{
                      await provider.createPost(user, widget.typePost);
                      Get.snackbar(
                        'Sucesso',
                        'Postagem criada com sucesso!',
                        snackPosition: SnackPosition.TOP,
                      );
                      Get.offAll(() => const ProfilePage());
                    }catch (e){
                      Get.snackbar(
                        'Erro',
                        'Não foi possível criar a postagem: ${e.toString()}',
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    }

                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  child: const Text('Publicar Postagem'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

