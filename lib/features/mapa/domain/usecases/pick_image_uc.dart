import 'dart:io';

import 'package:demopico/features/mapa/domain/interfaces/i_pick_image_repository.dart';

class PickImageUC {
  final IPickImageRepository _repository;

  PickImageUC(this._repository);

  Future<List<File>> pegarArquivos() async {
    try {
      return await _repository.pickImage();
    } catch (e) {
      print("Erro ao pegar imagens: $e");
      return [];
    }
  }
}