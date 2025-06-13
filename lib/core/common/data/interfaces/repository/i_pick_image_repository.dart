



import 'package:demopico/core/common/data/models/upload_file_model.dart';

abstract interface class IPickImageRepository {
  Future<List<UploadFileModel>> pickImage();
}