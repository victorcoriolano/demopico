import 'package:demopico/core/common/files/models/file_model.dart';
import 'package:demopico/core/common/files/models/upload_result_file_model.dart';
import 'package:demopico/core/common/usecases/upload_file_uc.dart';
import 'package:flutter/material.dart';

class UploadService {
  final UploadFileUC uploadFileUC;

  UploadService({required this.uploadFileUC});

  static UploadService? _instance;
  static UploadService get getInstance {
    _instance ??= UploadService(uploadFileUC: UploadFileUC.getInstance);
    return _instance!;
  }

  List<Stream<UploadStateFileModel>> uploadFiles(List<FileModel> files) {
    try {
    debugPrint("Iniciando upload de arquivos");
    final listResultFileModel = uploadFileUC.saveFiles(files);
    return listResultFileModel;
  } on Exception catch (e) {
    debugPrint("Erro ao fazer upload de arquivos: $e");
    rethrow;
  }catch (e) {
    debugPrint("Erro desconhecido ao fazer upload de arquivos: $e");
    rethrow;
  }
  }
}