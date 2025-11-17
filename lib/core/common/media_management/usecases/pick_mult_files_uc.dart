import 'package:demopico/core/common/errors/domain_failures.dart';
import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/core/common/media_management/interfaces/repository/i_pick_image_repository.dart';
import 'package:demopico/core/common/media_management/models/file_model.dart';
import 'package:demopico/core/common/media_management/services/image_picker_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PickMultFileUC {
  factory PickMultFileUC.getInstance() {
    return PickMultFileUC(repositoryIMP: ImagePickerService.getInstance);
  }

  final IPickFileRepository repositoryIMP;

  PickMultFileUC({
    required this.repositoryIMP,
  }) : _limit = 3;

  final List<FileModel> listFiles = [];
  int _limit;

  Future<void> execute() async {
    if (!_validateListFile(listFiles)) {
      debugPrint("Limite já atingido: ${listFiles.length}");
      throw FileLimitExceededFailure(
          messagemAdicional: "Limite atingido");
    }
    final selectedFiles = <FileModel>[];

    try {
      debugPrint("Chamou use case de pegar múltiplos arquivos");
      debugPrint("Quatidade de Files atuais: ${listFiles.length}");

      selectedFiles.addAll(await repositoryIMP.pickMultipleMedia(_limit));
    } on Failure catch (e) {
      debugPrint("Erro ao selecionar file vindo de outra camada: $e");
      rethrow;
    }

    if (!_validateListFile(selectedFiles)) {
      debugPrint("Files selecionados maior do que o limite");
      throw FileLimitExceededFailure(
          messagemAdicional: "O limite é 3 arquivos");
    }

    listFiles.addAll(selectedFiles);

    if (listFiles.any((file) => file.contentType == ContentType.unavailable)) {
      listFiles.clear();
      throw InvalidFormatFileFailure();}
  }

  bool _validateListFile(List<FileModel> files) =>
      files.length <= _limit;
}
