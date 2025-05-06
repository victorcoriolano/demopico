import 'dart:io';

import 'package:demopico/features/mapa/domain/interfaces/i_pick_image_repository.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerService implements IPickImageRepository{

  final _imagePicker = ImagePicker();

  @override
  Future<List<File>> pickImage() async {
    try{
      final pickedFiles = await _imagePicker.pickMultiImage(
        limit: 3,
      );
      if(pickedFiles.isNotEmpty){
        return Future.value(pickedFiles.map((e) => File(e.path)).toList());
      }else{
        throw Exception("Não foi possível selecionar a imagem");
      }
    }catch(e){
      throw Exception("Erro ao selecionar a imagem: $e");
    }
  }
}