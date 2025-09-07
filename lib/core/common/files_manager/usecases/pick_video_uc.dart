import 'package:demopico/core/common/errors/domain_failures.dart';
import 'package:demopico/core/common/errors/repository_failures.dart';
import 'package:demopico/core/common/files_manager/interfaces/repository/i_pick_image_repository.dart';
import 'package:demopico/core/common/files_manager/models/file_model.dart';
import 'package:demopico/core/common/files_manager/services/image_picker_service.dart';
import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:flutter/material.dart';

class PickVideoUC {
  static PickVideoUC? _pickVideoUC;
  static PickVideoUC get getInstance {
    _pickVideoUC ??= PickVideoUC(
      pickFileRepository: ImagePickerService.getInstance,
    );
    return _pickVideoUC!;
  }
  PickVideoUC({required this.pickFileRepository});

  final IPickFileRepository pickFileRepository;
  bool alredyExecute = false;

  Future<FileModel> execute() async {
    try{
      if (alredyExecute) throw FileLimitExceededFailure();
      final video = await pickFileRepository.pickVideo();
      alredyExecute = true;
      return video;
    }on Failure catch(e){
      debugPrint("Erro ao selecionar o video: $e");
      rethrow;
    }catch (e){
      throw UnknownFailure(unknownError: e);
    }
    
  }
}