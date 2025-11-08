import 'package:demopico/core/app/theme/theme.dart';
import 'package:demopico/core/common/auth/domain/entities/user_entity.dart';
import 'package:demopico/core/common/widgets/snackbar_utils.dart';
import 'package:demopico/features/mapa/presentation/controllers/comment_controller.dart';
import 'package:demopico/features/user/presentation/controllers/auth_view_model_account.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
 
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor:kRed,
        centerTitle: true,
        title: Text(
          'Comentários',
          
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
                                  style: const TextStyle(fontSize: 16, color: Colors.redAccent),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )
                          : provider.comments.isEmpty
                              ? Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
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
                                      margin: const EdgeInsets.symmetric(vertical: 6),
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: kWhite,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                comment.userIdentification.name,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                ),
                                              ),
                                              Text(
                                                _formatDate(comment.timestamp),
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey[600],
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            comment.content,
                                            style: const TextStyle(fontSize: 14),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                ),
              ),
              SafeArea(
                top: false,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: kWhite,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
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
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.send_rounded, color: kRed),
                        onPressed: _controller.text.isNotEmpty
                            ? () {
                                final content = _controller.text;
                                final currentUser =
                                    context.read<AuthViewModelAccount>().user;
                                if (currentUser == AnonymousUserEntity()) {
                                  return SnackbarUtils.userNotLogged(context);
                                }
                                UserEntity user = currentUser as UserEntity;
                                provider.addComment(
                                  widget.picoId,
                                  content,
                                  user.id,
                                  user.displayName.value,
                                  user.avatar!,
                                );
                                _controller.clear();
                                FocusScope.of(context).unfocus();
                              }
                            : null,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  String _formatDate(DateTime date) {
    final local = date.toLocal();
    final time = "${local.day.toString().padLeft(2, '0')}/"
        "${local.month.toString().padLeft(2, '0')} "
        "${local.hour.toString().padLeft(2, '0')}:${local.minute.toString().padLeft(2, '0')}";
    return time;
  }
}
