
import 'package:demopico/features/mapa/domain/interfaces/i_pick_image_repository.dart';
import 'package:demopico/features/mapa/domain/models/upload_file_model.dart';

class PickImageUC {
  final IPickImageRepository _repository;

  PickImageUC(this._repository);

  Future<List<UploadFileModel>> pegarArquivos() async {
    try {
      final files = await _repository.pickImage();
      return files;
    } catch (e) {
      print("Erro ao pegar imagens: $e");
      return [];
    }
  }
}