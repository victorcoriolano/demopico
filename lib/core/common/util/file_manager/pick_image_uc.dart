


import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/core/common/files_manager/interfaces/repository/i_pick_image_repository.dart';
import 'package:demopico/core/common/files_manager/models/file_model.dart';
import 'package:demopico/core/common/files_manager/services/image_picker_service.dart';
import 'package:demopico/core/common/errors/domain_failures.dart';
import 'package:flutter/material.dart';

class PickImageUc {

  factory PickImageUc.getInstance(){
    return PickImageUc(repositoryIMP: ImagePickerService.getInstance);
  } 
  final IPickFileRepository repositoryIMP;
  final List<FileModel> listFile = [];
  final int _limit = 3;

  PickImageUc({required this.repositoryIMP});

  Future<void> pick() async {
    if (!_validateListFile(listFile)){
      throw FileLimitExceededFailure(messagemAdicional: "Você já selecionou 3 fotos");
    }
    final selectedFile = <FileModel>[];
    try {
      debugPrint("Selecionando arquivos");
      selectedFile.addAll(await repositoryIMP.pickImages(_limit));
    } on Failure catch (e) {
      debugPrint("Erro ao selecionar imagens vindo de outra camada: $e");
      rethrow;
    }

    //validando arquivos selecionados 
    if (!_validateListFile(selectedFile)){
      throw FileLimitExceededFailure(messagemAdicional: "Selecione apenas 3 imagens");
    } 

    if (selectedFile.any((file) => file.contentType == ContentType.unavailable)) throw InvalidFormatFileFailure();

    //arquivos valido adicionando na lista

    listFile.addAll(selectedFile);
  }
  bool _validateListFile(List<FileModel> files) =>
      files.length <= _limit && listFile.length + files.length <= _limit;
}