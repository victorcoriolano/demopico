
import 'package:demopico/features/mapa/data/services/image_picker_service.dart';
import 'package:demopico/features/mapa/domain/interfaces/i_pick_image_repository.dart';
import 'package:demopico/features/mapa/domain/models/upload_file_model.dart';

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