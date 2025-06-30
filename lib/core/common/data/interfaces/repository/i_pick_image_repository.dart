
import 'package:demopico/core/common/data/models/upload_file_model.dart';

abstract interface class IPickFileRepository {
  Future<List<FileModel>> pickMultipleMedia();
  Future<List<FileModel>> pickImages();
  Future<FileModel> pickVideo();
}