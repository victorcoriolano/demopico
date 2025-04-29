import 'dart:io';

import 'package:demopico/features/mapa/domain/interfaces/i_save_image_repository.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ServiceFirebaseStorageImages implements ISaveImageRepository {
  FirebaseStorage bdInstance;

  ServiceFirebaseStorageImages(this.bdInstance);

  @override
  Future<List<String>> saveFiles(List<File> files) async {
    List<String> urls = [];

    try {
      for (File file in files) {

        if (!await file.exists()) {
          throw Exception("Arquivo ${file.path} não existe");
        } 

        final docRef = bdInstance.ref().child("spots").child("files");
        await docRef.putFile(file);

        //pegando as urls das imagens
        await docRef.getDownloadURL().then((value) {
          urls.add(value);
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
          throw Exception("Falha de rede, tente novamente");
        default:
          throw Exception("Erro no Firebase: ${e.message}");
      }
    }
  }
}
