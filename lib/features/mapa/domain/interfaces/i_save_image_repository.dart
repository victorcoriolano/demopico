import 'dart:io';


abstract class ISaveImageRepository {
  Future<List<String>> saveFiles(List<File> files);
}

