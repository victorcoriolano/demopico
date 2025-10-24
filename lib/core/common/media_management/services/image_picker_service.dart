import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/core/common/errors/repository_failures.dart';
import 'package:demopico/core/common/media_management/interfaces/repository/i_pick_image_repository.dart';
import 'package:demopico/core/common/media_management/models/file_model.dart';
import 'package:demopico/core/common/widgets/snackbar_utils.dart';
import 'package:demopico/features/external/api/gemini_api.dart';
import 'package:demopico/features/external/enuns/type_content.dart';
import 'package:demopico/features/external/interfaces/i_danger_content_api.dart';
import 'package:demopico/core/common/errors/domain_failures.dart';
import 'package:demopico/features/mapa/domain/enums/mime_type.dart';
import 'package:demopico/features/mapa/presentation/widgets/add_pico_modal/quarta_tela.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerService implements IPickFileRepository {
  
  static ImagePickerService? _imagePickerService;

  static ImagePickerService get getInstance {
    _imagePickerService ??= ImagePickerService();
    return _imagePickerService!;
  }
  final IDangerContentApi dangerContentApi = GeminiApi();
  final _imagePicker = ImagePicker();

  /// [XFile] → [FileModel]
  Future<List<FileModel>> _toFileModels(List<XFile> files) async {
    return Future.wait(
      files.map((xFile) async {
        final bytes = await xFile.readAsBytes();
        final mimeTypeStr = xFile.mimeType ?? mimeTypeToString(mimeTypeFromExtension(xFile.name));
          
          FileModel file = FileModel(
          fileName: xFile.name,
          filePath: xFile.path,
          bytes: bytes,
          contentType: mimeTypeStr != 'unknown'
              ? ContentTypeExtension.fromMime(mimeTypeStr)
              : ContentType.unavailable,
        );

        TypeContent tipoConteudo =  dangerContentApi.scanMidia(file.bytes);
        if(tipoConteudo == TypeContent.danger) throw DangerContent();
        if(tipoConteudo == TypeContent.warning) WarningContent();
        

        return  file;
      }),
    );
  }

  @override
  Future<FileModel> pickImage() async {
    try {
      final image = await _imagePicker.pickImage(source: ImageSource.gallery);
      if (image == null) throw NoFileSelectedFailure();

      final models = await _toFileModels([image]);
      return models.first;
    } catch (e) {
      throw UnknownFailure(unknownError: e);
    }
  }

  @override
  Future<List<FileModel>> pickImages(int limit) async {
    try {
      if (limit == 1) return [await pickImage()];

      final pickedFiles = await _imagePicker.pickMultiImage(limit: limit);
      if (pickedFiles.isEmpty) throw NoFileSelectedFailure();

      return _toFileModels(pickedFiles);
    } catch (e) {
      throw UnknownError(message: "Erro ao selecionar múltiplos arquivos: $e");
    }
  }

  @override
  Future<FileModel> pickVideo() async {
    try {
      final pickedFile = await _imagePicker.pickVideo(source: ImageSource.gallery);
      if (pickedFile == null) throw NoFileSelectedFailure();

      final models = await _toFileModels([pickedFile]);
      return models.first;
    } catch (e) {
      throw UnknownError(message: "Erro ao selecionar vídeo: $e");
    }
  }

  @override
  Future<List<FileModel>> pickMultipleMedia(int limit) async {
    try {
      final xFiles = await _imagePicker.pickMultipleMedia(limit: limit);
      if (xFiles.isEmpty) throw NoFileSelectedFailure();

      return _toFileModels(xFiles);
    } catch (e, st) {
      debugPrint("Erro ao selecionar múltiplos arquivos : $e stackTrace: $st");
      throw UnknownError(message: "Erro ao selecionar múltiplos arquivos: $e", stackTrace: st);
    }
  }


  MimeType mimeTypeFromExtension(String fileName) {
    final ext = fileName.split('.').last.toLowerCase();

    switch (ext) {
      case 'jpg':
      case 'jpeg':
        return MimeType.imageJpeg;
      case 'png':
        return MimeType.imagePng;
      case 'gif':
        return MimeType.imageGif;
      case 'webp':
        return MimeType.imageWebp;
      case 'heic':
        return MimeType.imageHeic;
      case 'heif':
        return MimeType.imageHeif;
      case 'svg':
        return MimeType.imageSvg;
      case 'mp4':
        return MimeType.videoMp4;
      case 'mov':
        return MimeType.videoMov;
      case 'mpeg':
      case 'mpg':
        return MimeType.videoMpeg;
      default:
        return MimeType.unknown;
    }
  }


  String mimeTypeToString(MimeType type) {
    switch (type) {
      case MimeType.imageJpeg:
        return 'image/jpeg';
      case MimeType.imagePng:
        return 'image/png';
      case MimeType.imageGif:
        return 'image/gif';
      case MimeType.imageWebp:
        return 'image/webp';
      case MimeType.imageHeic:
        return 'image/heic';
      case MimeType.imageHeif:
        return 'image/heif';
      case MimeType.imageSvg:
        return 'image/svg+xml';
      case MimeType.videoMp4:
        return "video/mp4";
      case MimeType.videoMov:
        return 'video/quicktime';
      case MimeType.videoMpeg:
        return 'video/mpeg';
      default:
        return 'unknown';
    }
  }
}
