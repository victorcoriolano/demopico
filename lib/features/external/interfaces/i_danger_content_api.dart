import 'package:demopico/core/common/media_management/models/file_model.dart';
import 'package:demopico/features/external/enuns/type_content.dart';

abstract class IDangerContentApi{
  Future<TypeContent> scanMidia(FileModel midia);
}