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
        final uploadTask = docRef.putData(file.bytes);
        final snapshot = await uploadTask;
        final snapshotUrl = await snapshot.ref.getDownloadURL();  
        
        
        urls.add(UploadResultFileModel(fileName: file.fileName, url: snapshotUrl));
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
    } catch (e) {
      throw Exception("Erro desconhecido: $e");
    }
  }
}
