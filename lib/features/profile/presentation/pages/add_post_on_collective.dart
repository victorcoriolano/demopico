import 'package:demopico/core/app/routes/app_routes.dart';
import 'package:demopico/core/app/theme/theme.dart';
import 'package:demopico/features/home/presentation/widgets/search_home_bar.dart';
import 'package:demopico/features/profile/presentation/view_model/post_provider.dart';
import 'package:demopico/features/profile/presentation/widgets/create_post_widgets/media_preview_list.dart';
import 'package:demopico/features/profile/presentation/widgets/create_post_widgets/media_preview_video.dart';
import 'package:demopico/features/profile/presentation/widgets/create_post_widgets/midia_input_card.dart';
import 'package:demopico/features/user/domain/enums/auth_state.dart';
import 'package:demopico/features/user/domain/enums/type_post.dart';
import 'package:demopico/features/user/presentation/controllers/auth_view_model_account.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class AddPostOnCollective extends StatefulWidget {

  const AddPostOnCollective({ super.key });

  @override
  State<AddPostOnCollective> createState() => _AddPostOnCollectiveState();
}

class _AddPostOnCollectiveState extends State<AddPostOnCollective> {
  bool isPost = true;
  TypePost typePost = TypePost.post;
  final TextEditingController _descriptionController = TextEditingController();

  void _showSpotSelectionDialog(BuildContext context, PostProvider provider) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return Center(
          child: SearchBarSpots(
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
       
    // Cores do tema escuro
    final backgroundColor = const Color(0xFF121212);
    final surfaceColor = const Color(0xFF1E1E1E);
    final primaryColor = kRed.withValues(alpha: 3);
    final textColor = Colors.white70;
    final hintColor = Colors.white38;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: surfaceColor,
        title: Text(
          "Nova postagem no coletivo", 
          style: const TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Consumer<PostProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Wrap(
                  alignment: WrapAlignment.spaceEvenly,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        setState(() {
                          isPost = true;
                          typePost = TypePost.post;
                        });
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: isPost ? kRed : null ,
                        foregroundColor: isPost ? kWhite : null,
                        side: BorderSide(color: isPost? kRed: kWhite)
                      ),
                      child: Text("Post"),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        setState(() {
                          isPost = false;
                          typePost = TypePost.fullVideo;
                        });
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: isPost ? null : kRed ,
                        foregroundColor: isPost ? null : kWhite,
                        side: BorderSide(color: isPost? kRed: kWhite)
                      ),
                      child: Text("Rec"),
                    ),
                    
                  ],
                ),
                const SizedBox(height: 16),
                // Input de mídia
                MediaInputCard(
                  onAddMedia: () async {
                    isPost
                        ? await provider.getFiles()
                        : await provider.getVideo();
                  },
                  typePost: typePost,
                ),
                const SizedBox(height: 16),
                // Pré-visualização
                isPost
                    ? MediaPreviewList(
                        mediaPaths: provider.filesModels,
                        onRemoveMedia: provider.removeMedia,
                      )
                    : MediaPreviewVideo(),
                const SizedBox(height: 24),

                // Botão para selecionar pico
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
                    backgroundColor: primaryColor,
                    foregroundColor: kWhite,
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
                  style: TextStyle(color: textColor),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: surfaceColor,
                    hintText: 'Descreva sua manobra, dica ou momento...',
                    hintStyle: TextStyle(color: hintColor),
                    labelText: 'Descrição',
                    labelStyle: TextStyle(color: textColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: Colors.grey.withValues(alpha: .3)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: primaryColor),
                    ),
                    alignLabelWithHint: true,
                  ),
                ),
                const SizedBox(height: 32),

                //mensionar usuários 
                
                // Botão de publicar
                ElevatedButton(
                  onPressed: () async {
                    final auth = context.read<AuthViewModelAccount>().authState;
                    switch (auth) {
                      case AuthAuthenticated():
                        try {
                          await provider.createPost(auth.user, typePost);
                          Get.snackbar(
                            'Sucesso',
                            'Postagem criada com sucesso!',
                            snackPosition: SnackPosition.TOP,
                            backgroundColor: surfaceColor,
                            colorText: Colors.white,
                          );
                          Get.back();
                        } catch (e) {
                          Get.snackbar(
                            'Erro',
                            'Não foi possível criar a postagem: ${e.toString()}',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: surfaceColor,
                            colorText: Colors.redAccent,
                          );
                        }
                      case AuthUnauthenticated():
                        Get.snackbar(
                          'Erro',
                          'Usuário não encontrado. Faça login novamente.',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: surfaceColor,
                          colorText: Colors.redAccent,
                        );
                        Get.toNamed(Paths.home);
                        return;
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: kWhite,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
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