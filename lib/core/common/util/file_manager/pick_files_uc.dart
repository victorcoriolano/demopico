

import 'package:demopico/core/common/errors/domain_failures.dart';
import 'package:demopico/core/common/files_manager/interfaces/repository/i_pick_image_repository.dart';
import 'package:demopico/core/common/files_manager/models/file_model.dart';
import 'package:demopico/core/common/files_manager/services/image_picker_service.dart';

class PickFileUC {
  static PickFileUC? _pickImageUC;

  static PickFileUC get getInstance{
    _pickImageUC ??= PickFileUC(repositoryIMP: ImagePickerService.getInstance);
    return _pickImageUC!;
  } 
  final IPickFileRepository repositoryIMP;
  int limit = 3;

  PickFileUC({required this.repositoryIMP});

  Future<List<FileModel>> execute() async {
    try {
      

      if(limit == 0) throw FileLimitExceededFailure();

      final files = await repositoryIMP.pickMultipleMedia(limit);
      limit -= files.length;

      return files;
    } catch (e) {
      throw Exception(e);
    }
  }
}