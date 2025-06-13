

//classe para representar o upload de um arquivo
import 'package:demopico/core/common/data/models/upload_file_model.dart';
import 'package:demopico/core/common/data/models/upload_result_file_model.dart';

abstract class UploadTaskInterface {
  //assinarura do retorno da model 
  UploadResultFileModel get upload;
}


//interface para armazenamento remoto
abstract class IFileRemoteDataSource {
  /// Dispara o upload e devolve sua abstração.
  List<UploadTaskInterface> uploadFile(List<UploadFileModel> file);

  Future<void> deleteFile(String path);
}