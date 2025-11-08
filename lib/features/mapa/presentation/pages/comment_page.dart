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
    // Carregar os comentários ao iniciar a tela
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
        centerTitle: true,
        title: const Text('Comentários'),
      ),
      body: Consumer<CommentController>(builder: (context, provider, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (provider.isLoading)
              const Center(child: CircularProgressIndicator())
            else if (provider.error != null)
              Center(child: Text(provider.error!))
            else if (provider.comments.isEmpty)
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: const Center(
                    child: Text(
                  'Nenhum comentário ainda. Seja o primeiro!',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                )),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: provider.comments.length,
                  itemBuilder: (context, index) {
                    final comment = provider.comments[index];
                    return ListTile(
                      title: Text(comment.content),
                      subtitle: Text(
                          'Por ${comment.userId} em ${comment.timestamp.toLocal()}'),
                    );
                  },
                ),
              ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: 'Adicionar comentário',
                  labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                  suffix: IconButton(
                    icon: const Icon(Icons.send, color: kRed),
                    onPressed: _controller.text.isNotEmpty
                        ? () {
                            final content = _controller.text;
                            final currentUser =
                                context.read<AuthViewModelAccount>().user;
                            if (currentUser == AnonymousUserEntity()) return SnackbarUtils.userNotLogged(context);
                            UserEntity user = currentUser as UserEntity;
                            provider.addComment(widget.picoId, content, user.displayName.value);
                            _controller.clear();
                          }
                        : null,
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
