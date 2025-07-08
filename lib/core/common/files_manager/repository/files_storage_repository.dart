



import 'package:demopico/core/common/files_manager/data_sources/remote/firebase_file_remote_datasource.dart';
import 'package:demopico/core/common/files_manager/interfaces/datasource/i_upload_task_datasource.dart';
import 'package:demopico/core/common/files_manager/interfaces/repository/i_upload_file_repository.dart';
import 'package:demopico/core/common/files_manager/models/file_model.dart';

class FilesStorageRepository implements IUploadFileRepository {

  static FilesStorageRepository? _filesStorageRepository;

  static FilesStorageRepository get getInstance {
    return _filesStorageRepository ??= FilesStorageRepository(FirebaseFileRemoteDatasource.getInstance);
  }

  final IFileRemoteDataSource dataSource;

  FilesStorageRepository(this.dataSource);

  @override
  ListUploadTask saveFiles(List<FileModel> files, String path) {
      final tasks = dataSource.uploadFile(files, path);
      return tasks.map((task) => task.uploadStream).toList();
  }

  Future<void> deleteFiles(List<String> urls) async {
    await  Future.wait(urls.map((url) => dataSource.deleteFile(url)));
  }

}