import 'package:demopico/core/app/routes/app_routes.dart';
import 'package:demopico/core/app/theme/theme.dart';
import 'package:demopico/core/common/auth/domain/entities/coletivo_entity.dart';
import 'package:demopico/core/common/auth/domain/entities/user_identification.dart';
import 'package:demopico/features/external/datasources/firebase/dto/firebase_dto_mapper.dart';
import 'package:demopico/features/home/presentation/widgets/search_home_bar.dart';
import 'package:demopico/features/profile/presentation/view_model/post_collective_view_model.dart';
import 'package:demopico/features/profile/presentation/view_model/post_provider.dart';
import 'package:demopico/features/profile/presentation/widgets/chat_widgets/container_users_selected.dart';
import 'package:demopico/features/profile/presentation/widgets/create_post_widgets/media_preview_list.dart';
import 'package:demopico/features/profile/presentation/widgets/create_post_widgets/media_preview_video.dart';
import 'package:demopico/features/profile/presentation/widgets/create_post_widgets/midia_input_card.dart';
import 'package:demopico/features/profile/presentation/widgets/search_page_widgets/search_bar_users.dart';
import 'package:demopico/features/user/domain/enums/auth_state.dart';
import 'package:demopico/features/user/domain/enums/type_post.dart';
import 'package:demopico/features/user/presentation/controllers/auth_view_model_account.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class CreatePostOnCollective extends StatefulWidget {
  final ColetivoEntity idCollective;
  const CreatePostOnCollective({super.key, required this.idCollective});

  @override
  State<CreatePostOnCollective> createState() => _CreatePostOnCollectiveState();
}

class _CreatePostOnCollectiveState extends State<CreatePostOnCollective> {
  bool isPost = true;
  TypePost typePost = TypePost.post;
  final TextEditingController _descriptionController = TextEditingController();

  void _showSpotSelectionDialog(
    BuildContext context,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return Center(
          child: SearchBarSpots(
            onTapSuggestion: (selectedSpot) {
              context.read<PostCollectiveViewModel>().selectSpot(selectedSpot);
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
      body: Consumer<PostCollectiveViewModel>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(12.0),
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
                          backgroundColor: isPost ? kRed : null,
                          foregroundColor:
                              isPost ? kWhite : kWhite.withAlpha(60),
                          side: BorderSide(
                            color: kWhite.withAlpha(60),
                          )),
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
                          backgroundColor: isPost ? null : kRed,
                          foregroundColor:
                              !isPost ? kWhite : kWhite.withAlpha(60),
                          side: BorderSide(
                            color: kWhite.withAlpha(60),
                          )),
                      child: Text("Rec"),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Input de mídia
                Visibility(
                  visible: isPost
                      ? (provider.filesModels.length < 3)
                      : provider.rec == null,
                  child: MediaInputCard(
                    onAddMedia: () async {
                      isPost
                          ? await provider.getFiles()
                          : await provider.getVideo();
                    },
                    typePost: typePost,
                  ),
                ),
                const SizedBox(height: 12),
                // Pré-visualização
                SizedBox(
                  height: 200,
                  child: isPost
                      ? MediaPreviewList(
                          mediaPaths: provider.filesModels,
                          onRemoveMedia: provider.removeMedia,
                        )
                      : MediaPreviewVideo(
                          videoFile: provider.rec,
                          onRemoveMedia: (file) => provider.resetVideo(),
                        ),
                ),
                const SizedBox(height: 24),

                // Botão para selecionar pico
                ElevatedButton.icon(
                  onPressed: () => _showSpotSelectionDialog(context),
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
                      borderSide: BorderSide(color: primaryColor),
                    ),
                    alignLabelWithHint: true,
                  ),
                ),
                const SizedBox(height: 12),

                //mensionar usuários
                SearchBarUsers(
                  hint: "Mencionar usuários",
                  onTapSuggestion: (suggestion) => provider.addMentionedUser(
                    UserIdentification(
                      id: suggestion.idUser,
                      name: suggestion.name,
                      profilePictureUrl: suggestion.photo,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                ContainerSelectedUsers(
                  hint: "Usuários mencionados apareceram aqui",
                  members: context.read<PostCollectiveViewModel>().mentionedUsers,
                  onRemoveMember: (user) =>
                      context.read<PostCollectiveViewModel>().removeMentionedUser(user),
                ),
                const SizedBox(height: 12),


                // Botão de publicar
                ElevatedButton(
                  onPressed: () async {
                    final auth = context.read<AuthViewModelAccount>().authState;
                    switch (auth) {
                      case AuthAuthenticated():
                        try {
                          await provider.createPost(auth.user, typePost, widget.idCollective);
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
