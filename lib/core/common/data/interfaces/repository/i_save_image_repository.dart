


import 'package:demopico/core/common/data/interfaces/datasource/i_upload_task_datasource.dart';
import 'package:demopico/core/common/data/models/file_model.dart';

abstract class ISaveFileRepository {
  List<UploadTaskInterface> saveFiles(List<FileModel> files);
}

