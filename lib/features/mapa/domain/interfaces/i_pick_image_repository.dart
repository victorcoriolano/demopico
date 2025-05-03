import 'dart:io';

abstract interface class IPickImageRepository {
  Future<List<File>> pickImage();
}