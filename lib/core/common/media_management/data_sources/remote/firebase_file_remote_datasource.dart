import 'dart:async';
import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/core/common/media_management/interfaces/datasource/i_upload_task_datasource.dart';
import 'package:demopico/core/common/media_management/models/file_model.dart';
import 'package:demopico/core/common/media_management/models/upload_result_file_model.dart';
import 'package:demopico/core/common/errors/repository_failures.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:demopico/core/common/mappers/firebase_errors_mapper.dart';
import 'package:flutter/material.dart';

class FirebaseFileRemoteDatasource implements IFileRemoteDataSource {
  static FirebaseFileRemoteDatasource? _firebaseFileRemoteDatasource;

  static FirebaseFileRemoteDatasource get getInstance {
    return _firebaseFileRemoteDatasource ??=
        FirebaseFileRemoteDatasource(firebaseStorage: FirebaseStorage.instance);
  }

  final FirebaseStorage firebaseStorage;

  FirebaseFileRemoteDatasource({required this.firebaseStorage});

  @override
  List<UploadTaskInterface> uploadFiles(List<FileModel> files, String path) {
    try{
      final String data = DateTime.now().toIso8601String();
      final tasks = files.map((file) {
        final task = firebaseStorage
            .ref()
            .child("$path/${file.fileName.split(".")[0]}_$data")
            .putData(
              file.bytes, 
              SettableMetadata(
                contentType: file.contentType.name),
              );
        return FirebaseUploadTask(uploadTask: task);
      }).toList();
    return tasks;
    }
    on FirebaseException catch(e) {
      debugPrint("Erro capturado no data source: ${e.message}");
      throw FirebaseErrorsMapper.map(e);
    }on Exception catch (e) {
      debugPrint("Erro desconhecido: $e");
      throw UnknownFailure(originalException: e);
    }
  }

  @override
  Future<void> deleteFile(String url) async {
    try {
      await firebaseStorage.refFromURL(url).delete();
    } on FirebaseException catch (e){
      throw FirebaseErrorsMapper.map(e);
    }
  }
  
  @override
  UploadTaskInterface uploadFile(FileModel file, String path) {
    try{
      if (file.contentType == ContentType.unavailable){
        throw UnavailableFailure();
      }
      final task = firebaseStorage
            .ref()
            .child("$path/${file.fileName.split(".")[0]}.${file.contentType.name}")
            .putData(
              file.bytes, 
              SettableMetadata(
                contentType: file.contentType.name),
              );
        return FirebaseUploadTask(uploadTask: task);
  }on FirebaseException catch(e) {
      debugPrint("Erro capturado no data source: ${e.message}");
      throw FirebaseErrorsMapper.map(e);
  }on Failure catch (e) {
      debugPrint("Tipo de arquivo desconhecido ou fora do escopo da aplicação: $e");
      rethrow;
    }on Exception catch (e) {
      debugPrint("Erro desconhecido: $e");
      throw UnknownFailure(originalException: e);
    }
  }
}

class FirebaseUploadTask implements UploadTaskInterface {
  
  final UploadTask uploadTask;
  

  FirebaseUploadTask({required this.uploadTask});


  @override
  Stream<UploadStateFileModel> get uploadStream async* {
    await for (final snapshot in uploadTask.snapshotEvents){
      final progress = snapshot.bytesTransferred / snapshot.totalBytes;
      yield UploadStateFileModel(
        progress: progress, 
        state: UploadState.uploading);
      
      if (snapshot.state == TaskState.success){
        final url = await snapshot.ref.getDownloadURL();
        yield UploadStateFileModel(
          progress: 1.0, 
          state: UploadState.success,
          url: url,
        );
      }

      if (snapshot.state == TaskState.error) {
        yield UploadStateFileModel(
          progress: progress, 
          state: UploadState.failure
        );
      }
    }
  }
}
