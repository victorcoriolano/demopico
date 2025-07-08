import 'package:demopico/core/common/errors/repository_failures.dart';
import 'package:demopico/core/common/files_manager/models/file_model.dart';
import 'package:demopico/core/common/files_manager/models/upload_result_file_model.dart';
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
  

  URLs uploadFiles(List<FileModel> files, String path) async {
    final urls = <String>[];
    try {
      final uploadTask = uploadFileUC.saveFiles(files, path);
      
      for (var task in uploadTask){
        final result = await task.firstWhere((state) => state.state == UploadState.success);
        urls.add(result.url!);
      }

      return urls;
       
    }on Exception catch (e) {
      debugPrint("Erro ao fazer upload: $e");
      throw UploadFileFailure(originalException: e);
    }catch (e){
      throw UnknownFailure(unknownError: e);
    }
  }
}

typedef URLs = Future<List<String>>;