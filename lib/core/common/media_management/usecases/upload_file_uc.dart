
import 'package:demopico/core/common/media_management/interfaces/datasource/i_upload_task_datasource.dart';
import 'package:demopico/core/common/media_management/models/file_model.dart';
import 'package:demopico/core/common/media_management/repository/files_storage_repository.dart';
import 'package:demopico/core/common/media_management/interfaces/repository/i_upload_file_repository.dart';



class UploadFileUC{

  static UploadFileUC? _saveImageUC;

 static UploadFileUC  get getInstance{
    _saveImageUC ??= UploadFileUC(saveImageRepositoryIMP: FilesStorageRepository.getInstance);
    return _saveImageUC!;
  } 

  final IUploadFileRepository saveImageRepositoryIMP;

  UploadFileUC({required this.saveImageRepositoryIMP});

  StreamUploadState execute(FileModel file, String path) {
    final uploadTask = saveImageRepositoryIMP.saveOneFile(file, path);
    return uploadTask;
  }
}