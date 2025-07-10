

import 'package:demopico/core/common/files_manager/interfaces/repository/i_pick_image_repository.dart';
import 'package:demopico/core/common/files_manager/models/file_model.dart';
import 'package:demopico/core/common/files_manager/services/image_picker_service.dart';
import 'package:demopico/core/common/errors/domain_failures.dart';
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

  Future<List<FileModel>> pick() async {
    try {
      if (limit == 0) throw FileLimitExceededFailure();
      final files = await repositoryIMP.pickImages(limit);
      
      limit -= files.length;
      
      if (files.length > 3) throw FileLimitExceededFailure();

      return files;
    } catch (e) {
      debugPrint("Erro ao selecionar imagens no use case: $e");
      rethrow;
    }
  }
}