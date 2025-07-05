import 'package:demopico/core/common/errors/repository_failures.dart';
import 'package:demopico/core/common/files/models/file_model.dart';
import 'package:demopico/core/common/files/models/upload_result_file_model.dart';
import 'package:demopico/core/common/usecases/upload_file_uc.dart';
import 'package:flutter/material.dart';

class UploadService {
  final UploadFileUC uploadFileUC;

  UploadService({required this.uploadFileUC});

  static UploadService? _instance;
  static UploadService get getInstance {
    _instance ??= UploadService(uploadFileUC: UploadFileUC.getInstance);
    return _instance!;
  }
  

  URLs uploadFiles(List<FileModel> files) async {
    final urls = <String>[];
    try {
      final uploadTask = uploadFileUC.saveFiles(files);
      
      for (var task in uploadTask){
        final result = await task.firstWhere((state) => state.state == UploadState.success);
        urls.add(result.url!);
      }

      return urls;
       
    }catch (e) {
      debugPrint("Erro ao fazer upload: $e");
      throw UploadFileFailure();
    }
  }
}

typedef URLs = Future<List<String>>;