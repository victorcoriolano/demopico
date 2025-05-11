import 'dart:io';
import 'dart:math';

import 'package:demopico/features/mapa/data/services/firebase_files_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

//mocks
class MockFirebaseStorage extends Mock implements FirebaseStorage {}
class MockUploadTask extends Mock implements UploadTask {}
class MockDownloadTask extends Mock implements DownloadTask {}
class MockStorageReference extends Mock implements Reference {}  

void main() {
  group("FirebaseFilesService", (){
    late FirebaseFilesService firebaseFilesService;
    late MockFirebaseStorage mockFirebaseStorage;
    late MockUploadTask mockUploadTask;
    late MockDownloadTask mockDownloadTask;
    late MockStorageReference mockStorageReference;
    late List<File> listFiles;
    

    setUp((){
      mockFirebaseStorage = MockFirebaseStorage();
      mockUploadTask = MockUploadTask();
      mockDownloadTask = MockDownloadTask();
      mockStorageReference = MockStorageReference();
      firebaseFilesService = FirebaseFilesService(mockFirebaseStorage);
      listFiles = [File("test/test_map/mocks/barriguitas.png")];
    });


    test("Deve subir um arquivo", () async {
      when(() => mockFirebaseStorage.ref().child("spots").child("files")).thenReturn(mockStorageReference);
      when(() => mockStorageReference.putFile(listFiles[0])).thenAnswer((_) => mockUploadTask);
      when(() => mockStorageReference.getDownloadURL()).thenAnswer((_) async => "Download Task");


      final result = await firebaseFilesService.saveFiles(listFiles);

      expect(result, isA<List<String>>());
      expect(result.length, 1);
      expect(result[0], isA<String>());
      expect(result.first, equals("Download Task"));
    });
  });
}