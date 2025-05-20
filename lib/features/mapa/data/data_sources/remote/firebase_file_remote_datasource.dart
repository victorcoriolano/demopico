import 'dart:async';

import 'package:demopico/features/mapa/data/data_sources/interfaces/upload_task_interface.dart';
import 'package:demopico/features/mapa/domain/models/upload_file_model.dart';
import 'package:demopico/features/mapa/domain/models/upload_result_file_model.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseFileRemoteDatasource implements FileRemoteDataSource {
  static FirebaseFileRemoteDatasource? _firebaseFileRemoteDatasource;

  static FirebaseFileRemoteDatasource get getInstance {
    return _firebaseFileRemoteDatasource ??=
        FirebaseFileRemoteDatasource(firebaseStorage: FirebaseStorage.instance);
  }

  final FirebaseStorage firebaseStorage;

  FirebaseFileRemoteDatasource({required this.firebaseStorage});

  @override
  List<UploadTaskInterface> uploadFile(List<UploadFileModel> files) {
    final tasks = files.map((file) {
      final task = firebaseStorage
          .ref()
          .child("spots/${file.fileName}")
          .putData(file.bytes);
      return FirebaseUploadTask(uploadTask: task);
    }).toList();

    return tasks;
  }
}

class FirebaseUploadTask implements UploadTaskInterface {
  final _controller = StreamController<double>();
  final UploadTask uploadTask;

  FirebaseUploadTask({required this.uploadTask}) {
    uploadTask.snapshotEvents.listen(
      (event) {
        if (event.state == TaskState.running) {
          final progress = event.bytesTransferred / event.totalBytes;
          _controller.add(progress);
        }
      },
      onDone: () => _controller.close(),
      onError: (error) => _controller.addError(error),
      cancelOnError: true,
    );
  }

  @override
  UploadResultFileModel get upload => UploadResultFileModel(
        progress: _controller.stream,
        url: uploadTask.snapshot.ref.getDownloadURL(),
      );
}
