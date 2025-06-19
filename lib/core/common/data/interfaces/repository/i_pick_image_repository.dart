
import 'package:demopico/core/common/data/models/upload_file_model.dart';

abstract interface class IPickFileRepository {
  Future<List<UploadFileModel>> pickMultipleMedia();
  Future<List<UploadFileModel>> pickImages();
  Future<UploadFileModel> pickVideo();
}