


import 'package:demopico/core/common/media_management/interfaces/datasource/i_upload_task_datasource.dart';
import 'package:demopico/core/common/media_management/models/file_model.dart';

abstract class IUploadFileRepository {
  ListUploadTask saveFiles(List<FileModel> files, String path);
}

