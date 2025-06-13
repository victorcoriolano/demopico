

import 'package:demopico/core/common/data/interfaces/repository/i_pick_image_repository.dart';
import 'package:demopico/core/common/data/models/upload_file_model.dart';
import 'package:demopico/core/common/data/services/image_picker_service.dart';

class PickImageUC {
  static PickImageUC? _pickImageUC;

  static PickImageUC get getInstance{
    _pickImageUC ??= PickImageUC(repositoryIMP: ImagePickerService.getInstance);
    return _pickImageUC!;
  } 
  final IPickImageRepository repositoryIMP;

  PickImageUC({required this.repositoryIMP});

  Future<List<UploadFileModel>> pegarArquivos() async {
    try {
      final files = await repositoryIMP.pickImage();
      
      if (files.length > 3) throw Exception("Limite de 3 arquivos");

      return files;
    } catch (e) {
      throw Exception(e);
    }
  }
}