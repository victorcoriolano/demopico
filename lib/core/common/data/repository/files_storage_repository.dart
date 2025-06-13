



import 'package:demopico/core/common/data/data_sources/remote/firebase_file_remote_datasource.dart';
import 'package:demopico/core/common/data/interfaces/datasource/i_upload_task_datasource.dart';
import 'package:demopico/core/common/data/interfaces/repository/i_save_image_repository.dart';
import 'package:demopico/core/common/data/models/upload_file_model.dart';

class FilesStorageRepository implements ISaveImageRepository {

  static FilesStorageRepository? _filesStorageRepository;

  static FilesStorageRepository get getInstance {
    return _filesStorageRepository ??= FilesStorageRepository(FirebaseFileRemoteDatasource.getInstance);
  }

  final IFileRemoteDataSource dataSource;

  FilesStorageRepository(this.dataSource);

  @override
  List<UploadTaskInterface> saveFiles(List<UploadFileModel> files) {
      return dataSource.uploadFile(files);
  }

  Future<void> deleteFiles(List<String> urls) async {
    await  Future.wait(urls.map((url) => dataSource.deleteFile(url)));
  }

}