import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:demopico/features/mapa/data/services/firebase_files_service.dart';
import 'package:demopico/features/mapa/domain/models/upload_file_model.dart';
import 'package:demopico/features/mapa/domain/models/upload_result_file_model.dart';
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
}

class MockStorageReference extends Mock implements Reference {}

// ===== Testes =====

void main() {
  group("FirebaseFilesService", () {
    late FirebaseFilesService firebaseFilesService;
    late MockFirebaseStorage mockFirebaseStorage;
    late FakeUploadTask fakeUploadTask;
    late MockTaskSnapshot mockTaskSnapshot;
    late MockStorageReference mockStorageReference;
    late UploadFileModel fileMock;

    setUp(() {
      mockFirebaseStorage = MockFirebaseStorage();
      mockTaskSnapshot = MockTaskSnapshot();
      fakeUploadTask = FakeUploadTask(snapshot: mockTaskSnapshot);
      mockStorageReference = MockStorageReference();
      firebaseFilesService = FirebaseFilesService(mockFirebaseStorage);

      fileMock = UploadFileModel(
        fileName: "teste.png",
        filePath: '/teste/teste.png',
        bytes: Uint8List.fromList([1, 2, 3]),
        contentType: 'image/png',
      );

      // Registrar Fallbacks
      registerFallbackValue(SettableMetadata(contentType: 'image/png'));
      registerFallbackValue(MockStorageReference());

    });

    test("Deve subir um arquivo e retornar URL", () async {
      when(() => mockFirebaseStorage.ref()).thenAnswer((_) => mockStorageReference);

      when(() => mockStorageReference.child("spots/${fileMock.fileName}"))
          .thenAnswer((_) => mockStorageReference);
      when(() => mockStorageReference.putData(
        fileMock.bytes,
        any(), // Espera um SettableMetadata
      )).thenAnswer((_) => fakeUploadTask);

      when(() => mockTaskSnapshot.ref).thenReturn(mockStorageReference);

      when(() => mockStorageReference.getDownloadURL())
          .thenAnswer((_) async => "http://test.com");

      final result = await firebaseFilesService.saveFiles([fileMock]);

      expect(result, isA<List<UploadResultFileModel>>());
      expect(result.length, equals(1));
      expect(result.first.fileName, equals("teste.png"));
      expect(result.first.url, equals("http://test.com"));
    });
  


  /// teste exceções 
  test("Deve lançar Exception de rede (SocketException)", () async {
  when(() => mockFirebaseStorage.ref()).thenReturn(mockStorageReference);
  when(() => mockStorageReference.child(any())).thenReturn(mockStorageReference);
  when(() => mockStorageReference.putData(fileMock.bytes, any()))
      .thenThrow(const SocketException("Sem conexão"));

  expect(
    () async => await firebaseFilesService.saveFiles([fileMock]),
    throwsA(predicate((e) => e is Exception && e.toString().contains("Falha de rede"))),
  );
});

test("Deve lançar Exception de autorização (FirebaseException - unauthorized)", () async {
  when(() => mockFirebaseStorage.ref()).thenReturn(mockStorageReference);
  when(() => mockStorageReference.child(any())).thenReturn(mockStorageReference);
  when(() => mockStorageReference.putData(fileMock.bytes, any())).thenThrow(
    FirebaseException(plugin: 'firebase_storage', code: 'storage/unauthorized', message: 'Sem permissão'),
  );

  expect(
    () async => await firebaseFilesService.saveFiles([fileMock]),
    throwsA(predicate((e) => e is Exception && e.toString().contains("Erro de autorização"))),
  );
});

test("Deve lançar Exception de limite excedido (FirebaseException - retry-limit-exceeded)", () async {
  when(() => mockFirebaseStorage.ref()).thenReturn(mockStorageReference);
  when(() => mockStorageReference.child(any())).thenReturn(mockStorageReference);
  when(() => mockStorageReference.putData(fileMock.bytes, any())).thenThrow(
    FirebaseException(plugin: 'firebase_storage', code: 'storage/retry-limit-exceeded'),
  );

  expect(
    () async => await firebaseFilesService.saveFiles([fileMock]),
    throwsA(predicate((e) => e is Exception && e.toString().contains("Limite excedido"))),
  );
});

test("Deve lançar Exception desconhecida", () async {
  when(() => mockFirebaseStorage.ref()).thenReturn(mockStorageReference);
  when(() => mockStorageReference.child(any())).thenReturn(mockStorageReference);
  when(() => mockStorageReference.putData(fileMock.bytes, any())).thenThrow(Exception("Erro genérico"));

  expect(
    () async => await firebaseFilesService.saveFiles([fileMock]),
    throwsA(predicate((e) => e is Exception && e.toString().contains("Erro desconhecido"))),
  );
});
});
}
