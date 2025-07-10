

import 'package:demopico/core/common/errors/domain_failures.dart';
import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/core/common/files_manager/interfaces/repository/i_pick_image_repository.dart';
import 'package:demopico/core/common/files_manager/models/file_model.dart';
import 'package:demopico/core/common/files_manager/services/image_picker_service.dart';
import 'package:flutter/material.dart';

class PickFileUC {
  static PickFileUC? _pickImageUC;

  static PickFileUC get getInstance{
    _pickImageUC ??= PickFileUC(repositoryIMP: ImagePickerService.getInstance);
    return _pickImageUC!;
  } 
  final IPickFileRepository repositoryIMP;
  int limit = 3;

  PickFileUC({required this.repositoryIMP});

  Future<List<FileModel>> execute() async {
    try {
      debugPrint("Chamou use case de pegar múltiplos arquivos");
      debugPrint("Limite de files atuais: $limit");

      if(limit == 0) throw FileLimitExceededFailure();

      final files = await repositoryIMP.pickMultipleMedia(limit);

      if(files.any((file) => file.contentType == ContentType.unavailable)) throw InvalidFormatFileFailure();

      limit -= files.length;

      return files;
    }on Failure catch (e) {
      debugPrint("Erro ao selecionar file caiu no use case: $e");
      rethrow;
    }
  }
}