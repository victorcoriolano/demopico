import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/core/common/files_manager/services/upload_service.dart';
import 'package:demopico/features/profile/domain/interfaces/i_post_repository.dart';
import 'package:demopico/features/profile/infra/repository/post_repository.dart';
import 'package:flutter/material.dart';

class DeletePostUc {
  final IPostRepository _repository;
  
  DeletePostUc({required IPostRepository repository})
  : _repository = repository;

  static DeletePostUc? _instance;
  static DeletePostUc get instance => 
    _instance ??= DeletePostUc(repository: PostRepository.getInstance);
  
  Future<void> execute(String idPost, List<String> urls) async {
    try {
      await Future.wait([
        _repository.deletePost(idPost),
        UploadService.getInstance.deleteFiles(urls)
      ]);
    } on Failure catch (e) {
      debugPrint("Erro ao deletar postagem - caiu no usecase: ${e.toString()}");
      rethrow;
    }

  }
}