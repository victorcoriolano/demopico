import 'package:demopico/core/common/widgets/snackbar_utils.dart';
import 'package:demopico/features/mapa/presentation/controllers/comment_controller.dart';
import 'package:demopico/features/user/presentation/controllers/profile_view_model.dart';
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
      body: Consumer<CommentController>(
        builder: (context, provider, child) {
          return Column(
            children: [
              if (provider.isLoading)
                const Center(child: CircularProgressIndicator())
              else if (provider.error != null)
                Center(child: Text(provider.error!))
              else if (provider.comments.isEmpty)
                const Center(child: Text('Nenhum comentário ainda. Seja o primeiro!'))
              else
                Expanded(
                  child: ListView.builder(
                    itemCount: provider.comments.length,
                    itemBuilder: (context, index) {
                      final comment = provider.comments[index];
                      return ListTile(
                        title: Text(comment.content),
                        subtitle: Text('Por ${comment.userId} em ${comment.timestamp.toLocal()}'),
                      );
                    },
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    labelText: 'Adicionar comentário',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: () {
                        final content = _controller.text;
                        final user = context.read<ProfileViewModel>().user;
                        if (user == null){
                          SnackbarUtils.userNotLogged(context);
                        }
                        if (content.isNotEmpty) {
                          provider.addComment(widget.picoId, content, user!.id);
                          _controller.clear();
                        }
                      },
                    ),
                  ),
                ),
              ),
            ],
          );
        }
      ),
    );
  }
}
