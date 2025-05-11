import 'dart:io';
import 'dart:math';

import 'package:demopico/features/mapa/data/services/firebase_files_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

//mocks
class MockFirebaseStorage extends Mock implements FirebaseStorage {}
class MockTaskSnapshot extends Mock implements TaskSnapshot {}
class MockUploadTask extends Mock implements UploadTask {}
class MockDownloadTask extends Mock implements DownloadTask {}
class MockStorageReference extends Mock implements Reference {}  

void main() {
  group("FirebaseFilesService", (){
    late FirebaseFilesService firebaseFilesService;
    late MockFirebaseStorage mockFirebaseStorage;
    late MockTaskSnapshot mockTaskSnapshot;
    late MockUploadTask mockUploadTask;
    late MockDownloadTask mockDownloadTask;
    late MockStorageReference mockStorageReference;
    late File fileMock;
    

    setUp((){
      mockFirebaseStorage = MockFirebaseStorage();
      mockTaskSnapshot = MockTaskSnapshot();
      mockUploadTask = MockUploadTask();
      mockDownloadTask = MockDownloadTask();
      mockStorageReference = MockStorageReference();
      firebaseFilesService = FirebaseFilesService(mockFirebaseStorage);

      fileMock = File("test/test_map/mocks/barriguitas.png");

      registerFallbackValue(fileMock);
    });



    test("Deve subir um arquivo", () async {
      when(() => mockFirebaseStorage.ref()).thenAnswer((_) => mockStorageReference);
      when(() => mockStorageReference.child(any())).thenReturn(mockStorageReference);
      when(() => mockStorageReference.putFile(fileMock)).thenAnswer((_) => mockUploadTask);
      when(() => mockStorageReference.getDownloadURL()).thenAnswer((_) async => "http://test.com");


      final result = await firebaseFilesService.saveFiles([fileMock]);

      expect(result, isA<List<String>>());
      expect(result.length, 1);
      expect(result[0], isA<String>());
      expect(result.first, equals("http://test.com"));
    });
  });
}