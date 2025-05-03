import 'dart:io';

import 'package:demopico/features/mapa/domain/interfaces/i_save_image_repository.dart';


class SaveImageUC{
  final ISaveImageRepository isaveImageRepository;

  SaveImageUC(this.isaveImageRepository);

  Future<List<String>> saveImage(List<File> files) async{
    try{
      List<String> urls = await isaveImageRepository.saveFiles(files);
      if(urls.isEmpty){
        throw Exception("Não foi possível salvar a imagem");
      }
      return urls;
    } on Exception catch(e) {
      print("Erro ao salvar imagem no firebase: $e");
      return [];
    }
  }
}