

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

  PickFileUC({required this.repositoryIMP});


  final List<FileModel> listFiles = [];
  int limit = 3;

  Future<List<FileModel>> execute() async {
    try {
      debugPrint("Chamou use case de pegar múltiplos arquivos");
      debugPrint("Quatidade de Files atuais: ${listFiles.length}");

      if(listFiles.length >= 3) {
        throw FileLimitExceededFailure(messagemAdicional: "Voce só pode selecionar agora $limit imagens");
      }

      listFiles.addAll(await repositoryIMP.pickMultipleMedia(limit));
      
      if(listFiles.length > 3 ) {
        listFiles.clear();
        throw FileLimitExceededFailure();
      }

      limit -= listFiles.length;
      
      if(listFiles.any(
        (file) => file.contentType == ContentType.unavailable)) throw InvalidFormatFileFailure();

      return listFiles;
    }on Failure catch (e) {
      debugPrint("Erro ao selecionar file caiu no use case: $e");
      rethrow;
    }
  }
}