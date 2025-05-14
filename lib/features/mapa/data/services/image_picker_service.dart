
import 'package:demopico/features/mapa/domain/interfaces/i_pick_image_repository.dart';
import 'package:demopico/features/mapa/domain/models/upload_file_model.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerService implements IPickImageRepository{

  final _imagePicker = ImagePicker();

  @override
  Future<List<UploadFileModel>> pickImage() async {
    try{
      final pickedFiles = await _imagePicker.pickMultiImage(
        limit: 3,
      );

      if(pickedFiles.isNotEmpty){
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
        
      }else{
        throw Exception("Nenhuma imagem foi selecionada",);
      }
    }catch(e){
      throw Exception("Erro ao selecionar a imagem: $e");
    }
  }
}