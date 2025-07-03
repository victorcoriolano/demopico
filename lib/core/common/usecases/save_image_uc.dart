
import 'package:demopico/core/common/files/models/file_model.dart';
import 'package:demopico/core/common/files/models/upload_result_file_model.dart';
import 'package:demopico/core/common/files/repository/files_storage_repository.dart';
import 'package:demopico/core/common/files/interfaces/repository/i_save_image_repository.dart';



class SaveImageUC{

  static SaveImageUC? _saveImageUC;

 static SaveImageUC  get getInstance{
    _saveImageUC ??= SaveImageUC(saveImageRepositoryIMP: FilesStorageRepository.getInstance);
    return _saveImageUC!;
  } 

  final ISaveFileRepository saveImageRepositoryIMP;

  SaveImageUC({required this.saveImageRepositoryIMP});

  List<UploadResultFileModel> saveImage(List<FileModel> files) {
    final uploadTask = saveImageRepositoryIMP.saveFiles(files);
    return uploadTask.map((task) => task.upload).toList();
  }
}