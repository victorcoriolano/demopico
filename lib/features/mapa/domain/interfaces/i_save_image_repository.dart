
import 'package:demopico/features/mapa/data/data_sources/interfaces/i_upload_task_datasource.dart';
import 'package:demopico/features/mapa/domain/models/upload_file_model.dart';


abstract class ISaveImageRepository {
  List<UploadTaskInterface> saveFiles(List<UploadFileModel> files);
}

