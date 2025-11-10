import 'package:demopico/core/common/media_management/data_sources/remote/firebase_file_remote_datasource.dart';
import 'package:demopico/core/common/media_management/interfaces/datasource/i_upload_task_datasource.dart';
import 'package:demopico/core/common/media_management/interfaces/repository/i_upload_file_repository.dart';
import 'package:demopico/core/common/media_management/models/file_model.dart';
import 'package:flutter/material.dart';

class FilesStorageRepository implements IUploadFileRepository {
  static FilesStorageRepository? _filesStorageRepository;

  static FilesStorageRepository get getInstance {
    return _filesStorageRepository ??=
        FilesStorageRepository(FirebaseFileRemoteDatasource.getInstance);
  }

  final IFileRemoteDataSource dataSource;

  FilesStorageRepository(this.dataSource);

  @override
  ListUploadTask saveFiles(List<FileModel> files, String path) {
    final tasks = dataSource.uploadFiles(files, path);
    return tasks.map((task) => task.uploadStream).toList();
  }

  Future<void> deleteFiles(List<String> urls) async {
    await Future.wait(
        urls.map((url) => dataSource.deleteFile(url).whenComplete(() {
              debugPrint("SUCCESSFULLY DELETED");
            })));
  }
  
  @override
  StreamUploadState saveOneFile(FileModel file, path) {
    return dataSource.uploadFile(file, path).uploadStream;
  }
}
