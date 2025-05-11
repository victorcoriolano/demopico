
import 'package:demopico/features/mapa/domain/models/upload_file_model.dart';
import 'package:demopico/features/mapa/domain/models/upload_result_file_model.dart';


abstract class ISaveImageRepository {
  Future<List<UploadResultFileModel>> saveFiles(List<UploadFileModel> files);
}

