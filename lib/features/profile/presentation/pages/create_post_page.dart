import 'package:demopico/core/app/routes/app_routes.dart';
import 'package:demopico/features/mapa/presentation/widgets/search_bar.dart';
import 'package:demopico/features/profile/presentation/pages/profile_page.dart';
import 'package:demopico/features/profile/presentation/services/verify_auth_and_get_user.dart';
import 'package:demopico/features/profile/presentation/view_model/post_provider.dart';
import 'package:demopico/features/profile/presentation/widgets/create_post_widgets/media_preview_list.dart';
import 'package:demopico/features/profile/presentation/widgets/create_post_widgets/media_preview_video.dart';
import 'package:demopico/features/profile/presentation/widgets/create_post_widgets/midia_input_card.dart';
import 'package:demopico/features/user/domain/enums/type_post.dart';
import 'package:demopico/features/user/presentation/controllers/auth_view_model_account.dart';
import 'package:demopico/features/user/presentation/controllers/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class CreatePostPage extends StatefulWidget {

  const CreatePostPage({super.key});

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
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return Center(
          child:SearchBarSpots(
            onTapSuggestion: (selectedSpot) {
              provider.selectSpot(selectedSpot);
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final TypePost typePost = Get.arguments as TypePost;
    final isPost = typePost == TypePost.post;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isPost
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
                    isPost
                     ? await provider.getFiles()
                     : await provider.getVideo();                    
                    
                  },
                  typePost: typePost,
                ),
                const SizedBox(height: 16),

                // Pré-visualização das mídias adicionadas
                isPost
                  ? MediaPreviewList(
                    mediaPaths: provider.filesModels,
                    onRemoveMedia: provider.removeMedia,
                  )
                  : MediaPreviewVideo(),
                const SizedBox(height: 24),

                // Botão para linkar ao pico no mapa
                ElevatedButton.icon(
                  onPressed: () => _showSpotSelectionDialog(context, provider),
                  icon: const Icon(Icons.location_on),
                  label: Text(
                    provider.selectedSpotId != null
                        ? 'Pico Selecionado: ${provider.selectedSpotId!.picoName}' 
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
                    final user = context.read<AuthViewModelAccount>().getCurrentUser();
                    if (user == null) {
                      Get.snackbar(
                        'Erro',
                        'Usuário não encontrado. Por favor, faça login novamente.',
                        snackPosition: SnackPosition.BOTTOM,
                      );
                      Get.toNamed(Paths.home);
                      return;
                    }
                    try{
                      await provider.createPost(user, typePost);
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

