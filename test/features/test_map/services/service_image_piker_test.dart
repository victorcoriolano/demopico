

  import 'package:demopico/core/common/files_manager/models/file_model.dart';
import 'package:demopico/core/common/files_manager/services/image_picker_service.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';
  import 'package:flutter_test/flutter_test.dart';
  import 'package:flutter/services.dart';

  class FakePlataformImagePicker extends  ImagePickerPlatform {
    final List<XFile> _mockFiles;

    FakePlataformImagePicker({required List<XFile> files}) : _mockFiles = files;

    @override
    Future<List<PickedFile>?> pickMultiImage({double? maxWidth, double? maxHeight, int? imageQuality}) async {
      return _mockFiles.map((e) => PickedFile(e.path)).toList();
    }

    @override
    Future<List<XFile>?> getMultiImage({double? maxWidth, double? maxHeight, int? imageQuality}) async{
      return _mockFiles;
    }

    
  } 

  void main() {
    

    group("ImagePikerService", () {
      setUp(() {
        var imagePickerPlatform = FakePlataformImagePicker(
          files: [
            XFile.fromData(
              Uint8List.fromList([1, 2, 3]),// mockando os bytes da imagem pra gerar a model corretamente
              name: "image1.jpg",
              mimeType: 'image/jpg',
              lastModified: DateTime.now(),
            ),
            XFile.fromData(
              Uint8List.fromList([4, 5, 6]),// mockando os bytes da imagem pra gerar a model corretamente
              name: "image2.jpg",
              mimeType: 'image/jpg',
              lastModified: DateTime.now(),
            ),
          ]
        );
        
        ImagePickerPlatform.instance = imagePickerPlatform;// mudando a instancia do imagePickerPlatform para a fake
      });

      tearDown(() {

      });

      test("Deve retornar a lista de imagem como File", () async {
        final service = ImagePickerService();
        final result = await service.pickImages(3);
        expect(result, isA<List<FileModel>>());
        expect(result.length, 2); // Verifica se retorna 2 arquivos
      });

      test("Deve lançar uma exeção quando não selecinar nenhuma imagem", () {
        ImagePickerPlatform.instance = FakePlataformImagePicker(
          files: [],
        );

        final service = ImagePickerService();
        expect(() => service.pickImages(3), throwsA(isA<Exception>()));
      });
    });
  }
