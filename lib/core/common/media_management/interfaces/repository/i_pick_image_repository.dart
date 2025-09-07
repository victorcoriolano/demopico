
import 'package:demopico/core/common/media_management/models/file_model.dart';

abstract interface class IPickFileRepository {
  Future<List<FileModel>> pickMultipleMedia(int limite);
  Future<List<FileModel>> pickImages(int limite);
  Future<FileModel> pickImage();
  Future<FileModel> pickVideo();
}