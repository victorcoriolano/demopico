import 'package:demopico/core/common/errors/repository_failures.dart';
import 'package:demopico/core/common/media_management/models/file_model.dart';
import 'package:demopico/core/common/media_management/models/upload_result_file_model.dart';
import 'package:demopico/core/common/media_management/usecases/upload_files_uc.dart';
import 'package:demopico/core/common/media_management/usecases/delete_file_uc.dart';
import 'package:flutter/material.dart';

class UploadService {
  final UploadFilesUC _uploadFileUC;
  final DeleteFileUc _deleteFileUc;

  UploadService({
    required UploadFilesUC uploadUc, 
    required DeleteFileUc deleteUc})
    : _deleteFileUc = deleteUc, _uploadFileUC = uploadUc;

  static UploadService? _instance;
  static UploadService get getInstance {
    _instance ??= UploadService(
      uploadUc: UploadFilesUC.getInstance,
      deleteUc: DeleteFileUc.instance,
    );
    return _instance!;
  }
  

  URLs uploadFiles(List<FileModel> files, String path) async {
    final urls = <String>[];
    try {
      final uploadTask = _uploadFileUC.saveFiles(files, path);
      
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

  Future<void> deleteFiles(List<String> urlsForDelete) async {
    await _deleteFileUc.deletarFile(urlsForDelete);
  }
  
}

typedef URLs = Future<List<String>>;