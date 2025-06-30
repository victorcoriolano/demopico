import 'dart:async';
import 'package:demopico/core/common/data/interfaces/datasource/i_upload_task_datasource.dart';
import 'package:demopico/core/common/data/models/upload_file_model.dart';
import 'package:demopico/core/common/data/models/upload_result_file_model.dart';
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
  List<UploadTaskInterface> uploadFile(List<FileModel> files) {
    try{
      final String data = DateTime.now().toIso8601String();
      final tasks = files.map((file) {
        final task = firebaseStorage
            .ref()
            .child("spots/${file.fileName}_$data")
            .putData(file.bytes);
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
  final _controller = StreamController<double>();
  final UploadTask uploadTask;
  final Completer<String> _urlCompleter = Completer<String>();

  FirebaseUploadTask({required this.uploadTask}) {
    uploadTask.snapshotEvents.listen(
      (event) {
        if (event.state == TaskState.running) {
          final progress = event.bytesTransferred / event.totalBytes;
          _controller.add(progress);
          debugPrint("Progress: $progress");
        }
        else if (event.state == TaskState.success) {
          debugPrint("Upload concluído");
          final url = event.ref.getDownloadURL();
          debugPrint("URL: $url");
          _urlCompleter.complete(url);
          _controller.add(1.0);
          _controller.close();
        }
      },
      onDone: () {
        debugPrint("Caiu no ondone");
        _controller.close();
      } ,
      onError: (error) {
        debugPrint("Caiu no onerror");
        _urlCompleter.completeError(error);
        _controller.addError(error);
        _controller.close();
      } ,
      cancelOnError: true,
    );
  }


  @override
  UploadResultFileModel get upload => UploadResultFileModel(
        progress: _controller.stream,
        url: _urlCompleter.future,
      );
}
