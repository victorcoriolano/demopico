import 'package:demopico/core/common/errors/repository_failures.dart';
import 'package:demopico/core/common/media_management/models/file_model.dart';
import 'package:demopico/core/common/media_management/models/upload_result_file_model.dart';
import 'package:demopico/core/common/media_management/usecases/upload_file_uc.dart';
import 'package:demopico/core/common/media_management/usecases/upload_files_uc.dart';
import 'package:demopico/core/common/media_management/usecases/delete_file_uc.dart';
import 'package:flutter/material.dart';

class UploadService {
  final UploadFilesUC _uploadFilesUC;
  final DeleteFileUc _deleteFileUc;
  final UploadFileUC _uploadFile;

  UploadService({
    required UploadFilesUC uploadUc, 
    required DeleteFileUc deleteUc,
    required UploadFileUC upload1File})
    : _deleteFileUc = deleteUc, _uploadFilesUC = uploadUc, _uploadFile = upload1File;

  static UploadService? _instance;
  static UploadService get getInstance {
    _instance ??= UploadService(
      upload1File: UploadFileUC.getInstance,
      uploadUc: UploadFilesUC.getInstance,
      deleteUc: DeleteFileUc.instance,
    );
    return _instance!;
  }
  

  URLs uploadFiles(List<FileModel> files, String path) async {
    final urls = <String>[];
    try {
      final uploadTask = _uploadFilesUC.saveFiles(files, path);
      
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

  Future<String> uploadAFileWithoutStream(FileModel file, String path) async {
    final streamUpload = _uploadFile.execute(file, path);
    final task = await streamUpload.firstWhere(
        (task) => task.state == UploadState.success || 
                   task.state == UploadState.failure,
      );
      if (task.state == UploadState.failure && task.url == null) throw UploadFailure();
      return task.url!;
  }
  
}

typedef URLs = Future<List<String>>;