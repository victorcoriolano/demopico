

import 'package:demopico/features/mapa/domain/models/upload_file_model.dart';

abstract interface class IPickImageRepository {
  Future<List<UploadFileModel>> pickImage();
}