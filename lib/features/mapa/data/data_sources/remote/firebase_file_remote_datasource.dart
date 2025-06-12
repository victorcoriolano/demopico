import 'dart:async';
import 'package:demopico/features/mapa/data/data_sources/interfaces/i_upload_task_datasource.dart';
import 'package:demopico/features/mapa/domain/models/upload_file_model.dart';
import 'package:demopico/features/mapa/domain/models/upload_result_file_model.dart';
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
  List<UploadTaskInterface> uploadFile(List<UploadFileModel> files) {
    try{
      final tasks = files.map((file) {
        final task = firebaseStorage
            .ref()
            .child("spots/${file.fileName}")
            .putData(file.bytes);
        return FirebaseUploadTask(uploadTask: task);
      }).toList();

    return tasks;
    }
    on FirebaseException catch(e) {
      debugPrint("Erro aqui no file: ${e.message}");
      throw FirebaseErrorsMapper.map(e);
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
