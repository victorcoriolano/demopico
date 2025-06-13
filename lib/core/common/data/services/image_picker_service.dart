import 'package:demopico/core/common/data/interfaces/repository/i_pick_image_repository.dart';
import 'package:demopico/core/common/data/models/upload_file_model.dart';

import 'package:image_picker/image_picker.dart';

class ImagePickerService implements IPickFileRepository {

  static ImagePickerService? _imagePickerService;
  
  static ImagePickerService get getInstance {
    _imagePickerService ??= ImagePickerService();
    return _imagePickerService!;
  }

  final _imagePicker = ImagePicker();

  @override
  Future<List<UploadFileModel>> pickImages() async {
    try {
      final pickedFiles = await _imagePicker.pickMultiImage(
        limit: 3,
      );
      if (pickedFiles.isEmpty) {
        throw Exception(
          "Nenhuma imagem foi selecionada",
        );
      }

      
        final uploadModel = Future.wait(pickedFiles.map((xFile) async {
          final bytes = await xFile.readAsBytes();
          return UploadFileModel(
            fileName: xFile.name,
            filePath: xFile.path,
            bytes: bytes,
            contentType: xFile.mimeType!,
          );
        }).toList());
        return uploadModel;
      
    } catch (e) {
      throw Exception("Erro ao selecionar a imagem: $e");
    }
  }
  
  @override
  Future<UploadFileModel> pickVideo()async {
    try {
      final pickedFile = await _imagePicker.pickVideo(
        source: ImageSource.gallery,
      );
      if (pickedFile == null) {
        throw Exception(
          "Nenhuma video foi selecionado",
        );
      }
      final bytes = await pickedFile.readAsBytes();
      
      return UploadFileModel(
            fileName: pickedFile.name,
            filePath: pickedFile.path,
            bytes: bytes,
            contentType: pickedFile.mimeType!,
      );
      
    } catch (e) {
      throw Exception("Erro ao selecionar a imagem: $e");
    }
  }
}
