
import 'package:demopico/core/common/media_management/interfaces/datasource/i_upload_task_datasource.dart';
import 'package:demopico/core/common/media_management/interfaces/repository/i_upload_file_repository.dart';
import 'package:demopico/core/common/media_management/models/file_model.dart';
import 'package:demopico/core/common/media_management/repository/files_storage_repository.dart';

class SaveImageUC{

  static SaveImageUC? _saveImageUC;

 static SaveImageUC  get getInstance{
    _saveImageUC ??= SaveImageUC(saveImageRepositoryIMP: FilesStorageRepository.getInstance);
    return _saveImageUC!;
  } 

  final IUploadFileRepository saveImageRepositoryIMP;

  SaveImageUC({required this.saveImageRepositoryIMP});

  ListUploadTask saveImage(List<FileModel> files, String path) {
    final uploadTask = saveImageRepositoryIMP.saveFiles(files, path);
    return uploadTask;
  }
}