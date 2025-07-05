
import 'package:demopico/core/common/files_manager/interfaces/datasource/i_upload_task_datasource.dart';
import 'package:demopico/core/common/files_manager/models/file_model.dart';
import 'package:demopico/core/common/files_manager/repository/files_storage_repository.dart';
import 'package:demopico/core/common/files_manager/interfaces/repository/i_upload_file_repository.dart';



class UploadFileUC{

  static UploadFileUC? _saveImageUC;

 static UploadFileUC  get getInstance{
    _saveImageUC ??= UploadFileUC(saveImageRepositoryIMP: FilesStorageRepository.getInstance);
    return _saveImageUC!;
  } 

  final IUploadFileRepository saveImageRepositoryIMP;

  UploadFileUC({required this.saveImageRepositoryIMP});

  ListUploadTask saveFiles(List<FileModel> files) {
    final uploadTask = saveImageRepositoryIMP.saveFiles(files);
    return uploadTask;
  }
}