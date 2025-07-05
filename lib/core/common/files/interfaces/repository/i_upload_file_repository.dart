


import 'package:demopico/core/common/files/interfaces/datasource/i_upload_task_datasource.dart';
import 'package:demopico/core/common/files/models/file_model.dart';

abstract class IUploadFileRepository {
  ListUploadTask saveFiles(List<FileModel> files);
}

