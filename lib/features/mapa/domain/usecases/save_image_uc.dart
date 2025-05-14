
import 'package:demopico/features/mapa/data/services/firebase_files_service.dart';
import 'package:demopico/features/mapa/domain/interfaces/i_save_image_repository.dart';
import 'package:demopico/features/mapa/domain/models/upload_file_model.dart';
import 'package:demopico/features/mapa/domain/models/upload_result_file_model.dart';


class SaveImageUC{

  static SaveImageUC? _saveImageUC;

 static SaveImageUC  get getInstance{
    _saveImageUC ??= SaveImageUC(saveImageRepositoryIMP: FirebaseFilesService.getInstance);
    return _saveImageUC!;
  } 

  final ISaveImageRepository saveImageRepositoryIMP;

  SaveImageUC({required this.saveImageRepositoryIMP});

  Future<List<UploadResultFileModel>> saveImage(List<UploadFileModel> files) async{
    try{
      List<UploadResultFileModel> urls = await saveImageRepositoryIMP.saveFiles(files);
      if(urls.isEmpty){
        throw Exception("Não foi possível salvar a imagem");
      }
      return urls;
    } on Exception catch(e) {
      throw Exception("Erro ao salvar imagem: $e");
      
    }
  }
}