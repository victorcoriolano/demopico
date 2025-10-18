
import 'package:demopico/core/common/errors/domain_failures.dart';
import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/core/common/media_management/interfaces/repository/i_pick_image_repository.dart';
import 'package:demopico/core/common/media_management/models/file_model.dart';
import 'package:flutter/cupertino.dart';

class PickOneImageUc {
  final IPickFileRepository _repository;

  PickOneImageUc({
    required IPickFileRepository repository})
    : _repository = repository;

  Future<FileModel> execute() async {
    try {
      final file = await _repository.pickImage();
      if (file.contentType == ContentType.unavailable) throw InvalidFormatFileFailure();
      return file;
    } on Failure catch (e){
      debugPrint("Erro UC PickOneImageUC: $e");
      rethrow;
    }
  }
}