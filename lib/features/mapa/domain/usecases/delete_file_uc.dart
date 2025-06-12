
import 'package:demopico/features/mapa/data/repositories/files_storage_repository.dart';

class DeleteFileUc {
  final FilesStorageRepository repository;

  DeleteFileUc({required this.repository});

  static DeleteFileUc? _instance;

  static DeleteFileUc get instance{
    _instance ??= DeleteFileUc(
      repository: FilesStorageRepository.getInstance);
    return _instance!;
  }

  Future<void> deletarFile(List<String> urls) async =>
      await repository.deleteFiles(urls);
  
}