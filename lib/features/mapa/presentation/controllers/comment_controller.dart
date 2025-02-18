import 'package:demopico/features/mapa/domain/entities/comment.dart';
import 'package:demopico/features/mapa/domain/use%20cases/comment_spot.dart';
import 'package:flutter/material.dart';

class CommentController extends ChangeNotifier {
  bool _isLoading = true;
  String? _error;
  List<Comment> _comments = [];

  bool get isLoading => _isLoading;
  String? get error => _error;
  List<Comment> get comments => _comments;

  final CommentSpotUC useCase;

  CommentController(this.useCase);


  // Função para carregar comentários de um servidor ou banco de dados
  Future<void> loadComments(String picoId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Substitua por uma chamada real ao banco de dados ou API

      _comments = await useCase.execulte(picoId);

    } catch (e) {
      _error = 'Erro ao carregar os comentários';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Função para adicionar um novo comentário
  Future<void> addComment(String picoId, String content) async {
    final newComment = Comment(
      id: picoId,
      peakId: picoId,
      userId: 'user123', // Pegar o ID do usuário logado
      content: content,
      timestamp: DateTime.now(),
    );
    await useCase.execulteAdd(newComment);
    _comments.add(newComment);

    notifyListeners();
  }
}
