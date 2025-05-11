import 'dart:io';

import 'package:demopico/features/mapa/domain/interfaces/i_save_image_repository.dart';
import 'package:demopico/features/mapa/domain/models/upload_file_model.dart';
import 'package:demopico/features/mapa/domain/models/upload_result_file_model.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseFilesService implements ISaveImageRepository {
  FirebaseStorage bdInstance;

  FirebaseFilesService(this.bdInstance);

  @override
  Future<List<UploadResultFileModel>> saveFiles(List<UploadFileModel> files) async {
    List<UploadResultFileModel> urls = [];

    try {
      for (UploadFileModel file in files) { 

        final docRef = bdInstance.ref().child("spots/${file.fileName}");
        await docRef.putData(file.bytes);

        
        //pegando as urls das imagens
        await docRef.getDownloadURL().then((value) {
          final uploadResult = UploadResultFileModel(fileName: file.fileName, url: value);
          urls.add(uploadResult);
        });
      }
      return urls;
    } on SocketException catch (e) {
      //erro de internet
      throw Exception("Falha de rede: $e, tente novamente");
      
    } on FirebaseException catch (e) {
      switch (e.code) {
        case 'storage/unauthorized':
          throw Exception("Erro de autorização: $e");
        case 'storage/retry-limit-exceeded':
          throw Exception("Limite excedido");
        default:
          throw Exception("Erro no Firebase: ${e.message}");
      }
    }
  }
}
