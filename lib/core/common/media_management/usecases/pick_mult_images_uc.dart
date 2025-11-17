import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/core/common/media_management/interfaces/repository/i_pick_image_repository.dart';
import 'package:demopico/core/common/media_management/models/file_model.dart';
import 'package:demopico/core/common/media_management/services/image_picker_service.dart';
import 'package:demopico/core/common/errors/domain_failures.dart';
import 'package:flutter/material.dart';

class PickMultiImagesUc {
  factory PickMultiImagesUc.getInstance() {
    return PickMultiImagesUc(repositoryIMP: ImagePickerService.getInstance);
  }

  final IPickFileRepository repositoryIMP;
  final List<FileModel> listFile = [];
  final int _limit = 3;

  PickMultiImagesUc({required this.repositoryIMP});

  Future<void> pick() async {
    // já bateu o limite
    if (listFile.length >= _limit) {
      throw FileLimitExceededFailure(
        messagemAdicional: "Você já selecionou $_limit fotos",
      );
    }

    final selectedFile = <FileModel>[];

    try {
      final restante = _limit - listFile.length;
      debugPrint("Selecionando $restante imagens restantes");

      selectedFile.addAll(await repositoryIMP.pickImages(restante));
    } on Failure catch (e) {
      debugPrint("Erro ao selecionar imagens: $e");
      rethrow;
    }

    // valida final
    if (listFile.length + selectedFile.length > _limit) {
      throw FileLimitExceededFailure(
        messagemAdicional: "O limite é $_limit imagens",
      );
    }

    if (selectedFile.any((file) => file.contentType == ContentType.unavailable)) {
      throw InvalidFormatFileFailure();
    }

    listFile.addAll(selectedFile);
  }
}
