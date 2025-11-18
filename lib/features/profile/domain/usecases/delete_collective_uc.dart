
import 'package:demopico/core/common/auth/domain/entities/coletivo_entity.dart';
import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/features/profile/domain/interfaces/i_coletivo_repository.dart';
import 'package:demopico/features/profile/domain/interfaces/i_post_repository.dart';
import 'package:demopico/features/profile/infra/repository/coletivo_repository_impl.dart';
import 'package:demopico/features/profile/infra/repository/post_repository.dart';
import 'package:flutter/material.dart';

class DeleteCollectiveUc {
  final IColetivoRepository _coletivoRepository;
  final IPostRepository _postRepository;

  DeleteCollectiveUc({required IColetivoRepository coletivoRepository, required IPostRepository postRepo})
      : _coletivoRepository = coletivoRepository, _postRepository = postRepo;

  static DeleteCollectiveUc? _instance;
  static DeleteCollectiveUc get instance =>
      _instance ??= DeleteCollectiveUc(
        coletivoRepository: ColetivoRepositoryImpl.instance, 
        postRepo: PostRepository.getInstance,
      );
  
  Future<void> execute(ColetivoEntity coletivo) async {
    try {
      await _coletivoRepository.deleteCollective(coletivo.id);
      final pubIds = coletivo.publications.map((pub) => pub.id).toList();
      for (final id in pubIds) {
        await _postRepository.deletePost(id);
      }


    }on Failure catch (e){
      debugPrint("erro ao criar coletivo: ${e.message}");
      rethrow;
    }
  
  }
}