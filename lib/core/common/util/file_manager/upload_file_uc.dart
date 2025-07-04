
import 'package:demopico/core/common/files/models/file_model.dart';
import 'package:demopico/core/common/files/models/upload_result_file_model.dart';
import 'package:demopico/core/common/files/repository/files_storage_repository.dart';
import 'package:demopico/core/common/files/interfaces/repository/i_save_image_repository.dart';



class UploadFileUC{

  static UploadFileUC? _saveImageUC;

 static UploadFileUC  get getInstance{
    _saveImageUC ??= UploadFileUC(saveImageRepositoryIMP: FilesStorageRepository.getInstance);
    return _saveImageUC!;
  } 

  final ISaveFileRepository saveImageRepositoryIMP;

  UploadFileUC({required this.saveImageRepositoryIMP});

  List<Stream<UploadStateFileModel>> saveFiles(List<FileModel> files) {
    final uploadTask = saveImageRepositoryIMP.saveFiles(files);
    return uploadTask.map((task) => task.uploadStream).toList();
  }
}