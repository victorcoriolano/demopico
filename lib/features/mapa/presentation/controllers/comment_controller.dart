import 'package:demopico/core/common/auth/domain/entities/user_identification.dart';
import 'package:demopico/features/mapa/domain/entities/comment.dart';
import 'package:demopico/features/mapa/domain/models/comment_model.dart';
import 'package:demopico/features/mapa/domain/usecases/comment_spot_uc.dart';
import 'package:flutter/material.dart';

class CommentController extends ChangeNotifier {
  
  static CommentController? _commentController;
   static CommentController  get getInstance{
    _commentController ??= CommentController(useCase: CommentSpotUC.getInstance);
    return _commentController!;
  } 

  bool _isLoading = true;
  String? _error;
  List<Comment> _comments = [];

  bool get isLoading => _isLoading;
  String? get error => _error;
  List<Comment> get comments => _comments;

  final CommentSpotUC useCase;

  CommentController({required this.useCase});


  Future<void> loadComments(String picoId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      _comments = await useCase.execulte(picoId);
      _comments.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    } catch (e) {
      _error = 'Erro ao carregar os comentários';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addComment(String id, String content, String idPico, String idUser, String nome, String? picture) async {
    final newComment = CommentModel(
      id: id,
      userIdentification: UserIdentification(
        id: idUser,
        name: nome,
        profilePictureUrl: picture
      ),
      picoId: idPico,
      content: content,
      timestamp: DateTime.now(),
    );
    await useCase.execulteAdd(newComment);
    _comments.add(newComment);

    notifyListeners();
  }
}
