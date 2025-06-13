


import 'package:demopico/core/common/data/interfaces/datasource/i_upload_task_datasource.dart';
import 'package:demopico/core/common/data/models/upload_file_model.dart';

abstract class ISaveImageRepository {
  List<UploadTaskInterface> saveFiles(List<UploadFileModel> files);
}

