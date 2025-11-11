import 'package:demopico/core/app/theme/theme.dart';
import 'package:demopico/core/common/auth/domain/entities/user_entity.dart';
import 'package:demopico/core/common/mixins/route_profile_validator.dart';
import 'package:demopico/core/common/widgets/snackbar_utils.dart';
import 'package:demopico/features/mapa/presentation/controllers/comment_controller.dart';
import 'package:demopico/features/user/domain/enums/auth_state.dart';
import 'package:demopico/features/user/presentation/controllers/auth_view_model_account.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class CommentPage extends StatefulWidget {
  final String picoId;

  const CommentPage({super.key, required this.picoId});

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  final TextEditingController _controller = TextEditingController();
  late CommentController comentController;

  @override
  void initState() {
    super.initState();
    comentController = context.read<CommentController>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      comentController.loadComments(widget.picoId);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.90;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kRed,
        centerTitle: true,
        title: const Text(
          'Comentários',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: Consumer<CommentController>(
        builder: (context, provider, child) {
          return Column(
            children: [
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: provider.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : provider.error != null
                          ? Center(
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Text(
                                  provider.error!,
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.redAccent),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )
                          : provider.comments.isEmpty
                              ? Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.chat_bubble_outline,
                                            size: 60, color: Colors.grey[400]),
                                        const SizedBox(height: 10),
                                        const Text(
                                          'Nenhum comentário ainda.\nSeja o primeiro!',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : ListView.builder(
                                  padding: const EdgeInsets.all(10),
                                  itemCount: provider.comments.length,
                                  itemBuilder: (context, index) {
                                    final comment = provider.comments[index];
                                    return Container(
                                      width: width,
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 6),
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: kWhite,
                                        borderRadius: BorderRadius.circular(16),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black
                                                .withValues(alpha: 0.04),
                                            blurRadius: 4,
                                            offset: const Offset(0, 2),
                                          )
                                        ],
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          // Avatar do usuário
                                          Expanded(
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    AuthState user =
                                                        AuthViewModelAccount
                                                            .instance.authState;
                                                    RouteProfileValidator
                                                        .validateRoute(
                                                            user,
                                                            comment
                                                                .userIdentification
                                                                .id);
                                                  },
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        left: 2, right: 12),
                                                    child: CircleAvatar(
                                                      radius: 22,
                                                      backgroundImage: comment
                                                                  .userIdentification
                                                                  .profilePictureUrl !=
                                                              null
                                                          ? NetworkImage(comment
                                                              .userIdentification
                                                              .profilePictureUrl!)
                                                          : const AssetImage(
                                                                  "assets/images/userPhoto.png")
                                                              as ImageProvider,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        comment
                                                            .userIdentification
                                                            .name,
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                      Text(
                                                        comment.content,
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          height: 1.3,
                                                        ),
                                                        softWrap:
                                                            true, // quebra em múltiplas linhas
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            margin:
                                                const EdgeInsets.only(left: 8),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  _formatHour(
                                                      comment.timestamp),
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey[700],
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                Text(
                                                  _formatFullDate(
                                                      comment.timestamp),
                                                  style: TextStyle(
                                                    fontSize: 11,
                                                    color: Colors.grey[500],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                ),
              ),
              _buildCommentInput(context, provider),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCommentInput(BuildContext context, CommentController provider) {
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: kWhite,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 6,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: 'Adicione um comentário...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.send_rounded, color: kRed),
              onPressed: () {
                // Verifica se o campo está vazio
                if (_controller.text.trim().isEmpty) {
                  return SnackbarUtils.showSnackbarError(
                    context,
                    'O comentário não pode ser vazio',
                  );
                }

                final content = _controller.text.trim();
                final currentUser = context.read<AuthViewModelAccount>().user;

                // Verifica se o usuário está logado
                if (currentUser == AnonymousUserEntity()) {
                  return SnackbarUtils.userNotLogged(context);
                }

                UserEntity user = currentUser as UserEntity;

                provider.addComment(
                  '',
                  content,
                  widget.picoId,
                  user.id,
                  user.displayName.value,
                  user.avatar,
                );

                _controller.clear();
                FocusScope.of(context).unfocus();
              },
            ),
          ],
        ),
      ),
    );
  }

  String _formatHour(DateTime date) {
    return DateFormat('HH:mm').format(date.toLocal());
  }

  String _formatFullDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date.toLocal());
  }
}
