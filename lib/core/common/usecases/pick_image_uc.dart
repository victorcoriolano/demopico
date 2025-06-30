

import 'package:demopico/core/common/data/interfaces/repository/i_pick_image_repository.dart';
import 'package:demopico/core/common/data/models/upload_file_model.dart';
import 'package:demopico/core/common/data/services/image_picker_service.dart';
import 'package:demopico/core/common/errors/domain_failures.dart';

class PickFileUC {
  static PickFileUC? _pickImageUC;

  static PickFileUC get getInstance{
    _pickImageUC ??= PickFileUC(repositoryIMP: ImagePickerService.getInstance);
    return _pickImageUC!;
  } 
  final IPickFileRepository repositoryIMP;

  PickFileUC({required this.repositoryIMP});

  Future<List<FileModel>> pick() async {
    try {
      final files = await repositoryIMP.pickImages();
      
      if (files.length > 3) throw FileLimitExceededFailure();

      return files;
    } catch (e) {
      throw Exception(e);
    }
  }
}