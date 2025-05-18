
import 'package:demopico/features/mapa/data/repositories/files_storage_repository.dart';
import 'package:demopico/features/mapa/domain/interfaces/i_save_image_repository.dart';
import 'package:demopico/features/mapa/domain/models/upload_file_model.dart';
import 'package:demopico/features/mapa/domain/models/upload_result_file_model.dart';


class SaveImageUC{

  static SaveImageUC? _saveImageUC;

 static SaveImageUC  get getInstance{
    _saveImageUC ??= SaveImageUC(saveImageRepositoryIMP: FilesStorageRepository.getInstance);
    return _saveImageUC!;
  } 

  final ISaveImageRepository saveImageRepositoryIMP;

  SaveImageUC({required this.saveImageRepositoryIMP});

  List<UploadResultFileModel> saveImage(List<UploadFileModel> files) {
    final uploadTask = saveImageRepositoryIMP.saveFiles(files);
    return uploadTask.map((task) => task.upload).toList();
  }
}