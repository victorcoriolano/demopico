  import 'package:demopico/features/mapa/data/services/local_storage_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

//criando mocks
class MockHistoryRepository extends Mock implements LocalStorageService {}
void main() {
  group("Deve testar o serviço de historico de spots", (){

    late MockHistoryRepository mockLocaService;

    setUp((){
      mockLocaService = MockHistoryRepository();
      when(() => mockLocaService.salvarNoHistorico(any(), any(), any()))
        .thenAnswer((_) async => {}); 
      when(() => mockLocaService.carregarHistorico()).thenAnswer((_) async => [
        {
          "nome": "teste",
          "latitude": 1.0,
          "longitude": 1.5
        }
      ]);
      when(() => mockLocaService.deleteEntry(any())).thenAnswer((_) async => {});
      when(() => mockLocaService.limparHistorico()).thenAnswer((_) async => {});
    });
    
    test("Deve salvar um spot no histórico", (){
      mockLocaService.salvarNoHistorico("teste", 1.0, 1.5);
      verify(() => mockLocaService.salvarNoHistorico("teste", 1.0, 1.5)).called(1);
      expect(mockLocaService.salvarNoHistorico("teste", 1.0, 1.5), completes);
    });

    test("Deve retornar uma lista de spots salvos no histórico", (){
      expect(mockLocaService.carregarHistorico(), completes);
    });

    test("Deve deletar um spot do histórico", (){
      expect(mockLocaService.deleteEntry("teste"), completes);
      verify(() => mockLocaService.deleteEntry("teste")).called(1);
    });

    test("Deve limpar a lista de spots do histórico", (){
            expect(mockLocaService.limparHistorico(), completes);

      verify(() => mockLocaService.limparHistorico()).called(1);
    });
  });

}