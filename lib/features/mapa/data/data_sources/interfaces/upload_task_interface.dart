
import 'package:demopico/features/mapa/domain/models/upload_file_model.dart';

//classe para representar o upload de um arquivo
abstract class UploadTaskInterface {
  //emite o progresso do upload
  Stream<double> get onProgress;

  //emite o resultado do upload
  Future<String> get url; 
}


//interface para armazenamento remoto
abstract class FileRemoteDataSource {
  /// Dispara o upload e devolve sua abstração.
  List<UploadTaskInterface> uploadFile(List<UploadFileModel> file);
}