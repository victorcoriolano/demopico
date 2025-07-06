


import 'package:demopico/core/common/files_manager/interfaces/datasource/i_upload_task_datasource.dart';
import 'package:demopico/core/common/files_manager/models/file_model.dart';

abstract class IUploadFileRepository {
  ListUploadTask saveFiles(List<FileModel> files, String path);
}

