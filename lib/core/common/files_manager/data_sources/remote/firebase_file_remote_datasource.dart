import 'dart:async';
import 'package:demopico/core/common/files_manager/interfaces/datasource/i_upload_task_datasource.dart';
import 'package:demopico/core/common/files_manager/models/file_model.dart';
import 'package:demopico/core/common/files_manager/models/upload_result_file_model.dart';
import 'package:demopico/core/common/errors/repository_failures.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:demopico/features/mapa/data/mappers/firebase_errors_mapper.dart';
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
  List<UploadTaskInterface> uploadFile(List<FileModel> files, String path) {
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
