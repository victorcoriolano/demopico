
import 'package:demopico/features/mapa/domain/models/upload_file_model.dart';
import 'package:demopico/features/mapa/domain/models/upload_result_file_model.dart';

//classe para representar o upload de um arquivo
abstract class UploadTaskInterface {
  //assinarura do retorno da model 
  UploadResultFileModel get upload;
}


//interface para armazenamento remoto
abstract class FileRemoteDataSource {
  /// Dispara o upload e devolve sua abstração.
  List<UploadTaskInterface> uploadFile(List<UploadFileModel> file);
}