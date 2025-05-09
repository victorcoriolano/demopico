import 'dart:io';

import 'package:demopico/features/mapa/data/services/image_picker_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/services.dart'; // Adicione este import

void main() {
  const channel = MethodChannel('plugins.flutter.io/image_picker');

  group("ImagePikerService", () {
    setUp(() {
      TestWidgetsFlutterBinding.ensureInitialized();
      // Configurar o mock para pickMultiImage
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
        if (methodCall.method == 'pickMultiImage') {
          return [
            '/fake/path/image1.jpg', '/fake/path/image2.jpg' //arquivos falsos
          ];
        }
        return null;
      });
    });

    tearDown(() {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, null);
    });

    test("Deve retornar a lista de imagem como File", () async {
      final service = ImagePickerService();
      final result = await service.pickImage();
      expect(result, isA<List<File>>());
      expect(result.length, 2); // Verifica se retorna 2 arquivos
    });

    test("Deve lançar uma exeção quando não selecinar nenhuma imagem", () {
       TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (MethodCall methodCall) async => []);

      final service = ImagePickerService();
      expect(() => service.pickImage(), throwsA(isA<Exception>()));
    });
  });
}
