import 'dart:async';
import 'dart:typed_data';

import 'package:demopico/core/common/files/data_sources/remote/firebase_file_remote_datasource.dart';
import 'package:demopico/core/common/files/interfaces/datasource/i_upload_task_datasource.dart';
import 'package:demopico/core/common/files/models/file_model.dart';
import 'package:demopico/core/common/files/models/upload_result_file_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// ===== Mocks e Fakes =====

class MockFirebaseStorage extends Mock implements FirebaseStorage {}

class MockTaskSnapshot extends Mock implements TaskSnapshot {}

class FakeUploadTask extends Fake implements UploadTask {
  @override
  final TaskSnapshot snapshot;

  FakeUploadTask({required this.snapshot});

  @override
  Future<T> then<T>(FutureOr<T> Function(TaskSnapshot) onValue, {Function? onError}) {
    return Future.value(onValue(snapshot));
  }

  @override
  Stream<TaskSnapshot> get snapshotEvents => Stream.value(snapshot);
}

class MockStorageReference extends Mock implements Reference {}

// ===== Testes =====

void main() {
  group("FirebaseFilesService", () {
    late FirebaseFileRemoteDatasource firebaseFilesRemoteDatasource;
    late MockFirebaseStorage mockFirebaseStorage;
    late FakeUploadTask fakeUploadTask;
    late MockTaskSnapshot mockTaskSnapshot;
    late MockStorageReference mockStorageReference;
    late FileModel fileMock;

    setUp(() {
      mockFirebaseStorage = MockFirebaseStorage();
      mockTaskSnapshot = MockTaskSnapshot();
      fakeUploadTask = FakeUploadTask(snapshot: mockTaskSnapshot);
      mockStorageReference = MockStorageReference();
      firebaseFilesRemoteDatasource = FirebaseFileRemoteDatasource(firebaseStorage: mockFirebaseStorage);

      fileMock = FileModel(
        fileName: "teste.png",
        filePath: '/teste/teste.png',
        bytes: Uint8List.fromList([1, 2, 3]),
        contentType: ContentType.png,
      );

      
    });

    test("Deve subir um arquivo e retornar uma tarefa de Upload task", () async {
      when(() => mockFirebaseStorage.ref()).thenAnswer((_) => mockStorageReference);
      when(() => mockTaskSnapshot.state).thenReturn(TaskState.running);
      when(() => mockTaskSnapshot.bytesTransferred).thenReturn(100);
      when(() => mockTaskSnapshot.totalBytes).thenReturn(100);
      when(() => mockStorageReference.child(any()))
          .thenAnswer((_) => mockStorageReference);
      when(() => mockStorageReference.putData(
        fileMock.bytes,
        any(), // Espera um SettableMetadata
      )).thenAnswer((_) => fakeUploadTask);

      when(() => mockTaskSnapshot.ref).thenReturn(mockStorageReference);

      when(() => mockStorageReference.getDownloadURL())
          .thenAnswer((_) async => "http://test.com");

      final result = firebaseFilesRemoteDatasource.uploadFile([fileMock]);

      //veridicando se o resultado é uma instância de UploadTaskInterface
      expect(result, isA<List<UploadTaskInterface>>());

      //verificando se o resultado contem uma uploadResultFileModel
      expect(result[0].upload, isA<UploadResultFileModel>());

      
    });
  });
}
