
import 'package:demopico/core/common/media_management/interfaces/datasource/i_upload_task_datasource.dart';
import 'package:demopico/core/common/media_management/models/file_model.dart';
import 'package:demopico/core/common/media_management/repository/files_storage_repository.dart';
import 'package:demopico/core/common/media_management/interfaces/repository/i_upload_file_repository.dart';



class UploadFilesUC{

  static UploadFilesUC? _saveImageUC;

 static UploadFilesUC  get getInstance{
    _saveImageUC ??= UploadFilesUC(saveImageRepositoryIMP: FilesStorageRepository.getInstance);
    return _saveImageUC!;
  } 

  final IUploadFileRepository saveImageRepositoryIMP;

  UploadFilesUC({required this.saveImageRepositoryIMP});

  ListUploadTask saveFiles(List<FileModel> files, String path) {
    final uploadTask = saveImageRepositoryIMP.saveFiles(files, path);
    return uploadTask;
  }
}