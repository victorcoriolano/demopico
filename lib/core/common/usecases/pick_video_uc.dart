import 'package:demopico/core/common/data/interfaces/repository/i_pick_image_repository.dart';
import 'package:demopico/core/common/data/services/image_picker_service.dart';
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

  Future<void> call() async {
    try{
      await pickFileRepository.pickVideo();
    }on Failure catch(e){
      debugPrint("Erro ao selecionar o video: $e");
      rethrow;
    }
    
  }
}