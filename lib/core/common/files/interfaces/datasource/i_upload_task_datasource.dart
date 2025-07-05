

//classe para representar o upload de um arquivo
import 'package:demopico/core/common/files/models/file_model.dart';
import 'package:demopico/core/common/files/models/upload_result_file_model.dart';

abstract class UploadTaskInterface {
  //assinarura do retorno da model 
  Stream<UploadStateFileModel> get uploadStream;
}


//interface para armazenamento remoto
abstract class IFileRemoteDataSource {
  /// Dispara o upload e devolve a abstração.
  List<UploadTaskInterface> uploadFile(List<FileModel> file);

  Future<void> deleteFile(String path);
}

typedef StreamUploadState = Stream<UploadStateFileModel>;
typedef ListUploadTask = List<StreamUploadState>;