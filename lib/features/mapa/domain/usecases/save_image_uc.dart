
import 'package:demopico/features/mapa/domain/interfaces/i_save_image_repository.dart';
import 'package:demopico/features/mapa/domain/models/upload_file_model.dart';
import 'package:demopico/features/mapa/domain/models/upload_result_file_model.dart';


class SaveImageUC{
  final ISaveImageRepository isaveImageRepository;

  SaveImageUC(this.isaveImageRepository);

  Future<List<UploadResultFileModel>> saveImage(List<UploadFileModel> files) async{
    try{
      List<UploadResultFileModel> urls = await isaveImageRepository.saveFiles(files);
      if(urls.isEmpty){
        throw Exception("Não foi possível salvar a imagem");
      }
      return urls;
    } on Exception catch(e) {
      print("Erro ao salvar imagem no firebase: $e");
      return [];
    }
  }
}