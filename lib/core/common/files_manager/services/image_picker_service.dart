import 'package:demopico/core/common/errors/repository_failures.dart';
import 'package:demopico/core/common/files_manager/interfaces/repository/i_pick_image_repository.dart';
import 'package:demopico/core/common/files_manager/models/file_model.dart';
import 'package:demopico/core/common/errors/domain_failures.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

class ImagePickerService implements IPickFileRepository {

  static ImagePickerService? _imagePickerService;
  
  static ImagePickerService get getInstance {
    _imagePickerService ??= ImagePickerService();
    return _imagePickerService!;
  }

  final _imagePicker = ImagePicker();

  @override
  Future<List<FileModel>> pickImages(int limite) async {
    try {
      if (limite ==1 ) {
        // Não é possivel execultar o pickMultImage com somente
        // 1 de limite (não faz sentido também )
        // executando o pick Image
        final listForOneFile = <FileModel>[];
        listForOneFile.add(await pickImage());
        return listForOneFile;

      }
      final pickedFiles = await _imagePicker.pickMultiImage(
        limit: limite,
      );

      if (pickedFiles.isEmpty) throw NoFileSelectedFailure();

      
        final uploadModel = Future.wait(pickedFiles.map((xFile) async {
          final bytes = await xFile.readAsBytes();
          return FileModel(
            fileName: xFile.name,
            filePath: xFile.path,
            bytes: bytes,
            contentType: xFile.mimeType != null 
              ? ContentTypeExtension.fromMime(xFile.mimeType!)
              : ContentType.unavailable,
          );
        }).toList());
        return uploadModel;
      
    } catch (e) {
      throw UnknownError(message: "Erro ao selecionar a multiplos arquivos: $e");
    }
  }
  
  @override
  Future<FileModel> pickVideo()async {
    try {
      final pickedFile = await _imagePicker.pickVideo(
        source: ImageSource.gallery,
        
      );
      if (pickedFile == null) throw NoFileSelectedFailure();
      
      final bytes = await pickedFile.readAsBytes();
      
      return FileModel(
            fileName: pickedFile.name,
            filePath: pickedFile.path,
            bytes: bytes,
            contentType: pickedFile.mimeType != null 
              ? ContentTypeExtension.fromMime(pickedFile.mimeType!)
              : ContentType.unavailable,
      );
      
    } catch (e) {
      throw UnknownError(message: "Erro ao selecionar a video: $e");
    }
  }
  
  @override
  Future<List<FileModel>> pickMultipleMedia(int limit) async {
    try{

      final xFiles = await _imagePicker.pickMultipleMedia(
        limit: limit,
      );
      if (xFiles.isEmpty) {
        throw NoFileSelectedFailure();
      }

      final files = await Future.wait(xFiles.map((xFile) async {
        final bytes = await xFile.readAsBytes();
        return FileModel(
          fileName: xFile.name,
          filePath: xFile.path,
          bytes: bytes,
          contentType: xFile.mimeType != null 
            ? ContentTypeExtension.fromMime(xFile.mimeType!)
            : ContentType.unavailable,
        );
      }).toList());

      return files;
    } catch (e, st) {
      debugPrint("Erro ao selecionar multiplos arquivos : $e stackTrace: $st");
      throw UnknownError(message: "Erro ao selecionar multiplos arquivos: $e", stackTrace: st);
    }
  }
  
  @override
  Future<FileModel> pickImage() async {
    try {
      final image = await _imagePicker.pickImage(
        source: ImageSource.gallery);

      if (image == null) throw NoFileSelectedFailure();

      final bytes = await image.readAsBytes();
      return FileModel(
          fileName: image.name,
          filePath: image.path,
          bytes: bytes,
          contentType: image.mimeType != null 
            ? ContentTypeExtension.fromMime(image.mimeType!)
            : ContentType.unavailable,
        );
    } catch (e) {
      throw UnknownFailure(unknownError: e);
    }
  }
}
