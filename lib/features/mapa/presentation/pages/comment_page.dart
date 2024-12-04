import 'package:demopico/features/mapa/presentation/controllers/comment_controller.dart';
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

  @override
  void initState() {
    super.initState();
    // Carregar os comentários ao iniciar a tela
    context.read<CommentController>().loadComments(widget.picoId);
  }

  @override
  Widget build(BuildContext context) {
    final commentController = context.watch<CommentController>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Comentários'),
      ),
      body: Column(
        children: [
          if (commentController.isLoading)
            Center(child: CircularProgressIndicator())
          else if (commentController.error != null)
            Center(child: Text(commentController.error!))
          else if (commentController.comments.isEmpty)
            Center(child: Text('Nenhum comentário ainda. Seja o primeiro!'))
          else
            Expanded(
              child: ListView.builder(
                itemCount: commentController.comments.length,
                itemBuilder: (context, index) {
                  final comment = commentController.comments[index];
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
                  icon: Icon(Icons.send),
                  onPressed: () {
                    final content = _controller.text;
                    if (content.isNotEmpty) {
                      context.read<CommentController>().addComment(widget.picoId, content);
                      _controller.clear();
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
