
import 'package:demopico/features/mapa/data/repositories/spot_repository_impl.dart';
import 'package:demopico/features/mapa/domain/models/pico_model.dart';
import 'package:demopico/features/mapa/domain/usecases/create_spot_uc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

final class MockPicoRepository extends Mock implements SpotRepositoryImpl {}
final class MockPico extends Mock implements PicoModel {}

    final testPico = PicoModel(
      userID: "490320",
      id: "1",
      imgUrls: ["url"],
      tipoPico: "rua",
      modalidade: "street",
      nota: 4.5,
      numeroDeAvaliacoes: 10,
      long: -46.57421,
      lat: -23.55052,
      description: "Teste",
      atributos: {"teste": 2},
      obstaculos: ["corrimão"],
      utilidades: ["banheiro"],
      userName: "user123",
      picoName: "Pico Legal",
    );

void main() {
    group("deve execultar a lógica de negócio corretamente",() {
      test("deve retornar uma pico model ao criar pico", () async {
        //testar se o pico foi criado e retornar true
        final mockRepository =  MockPicoRepository();
        final useCase = CreateSpotUc(spotRepositoryIMP: mockRepository);
        final mockPico = MockPico();

        when(() => mockRepository.createSpot(mockPico)).thenAnswer((_) async => testPico);

        final result = await useCase.createSpot(mockPico);
        expect(result, isA<PicoModel>());
        expect(result.id, "1");
      });

      test("deve propagar exception do repository", () async {
        final mockRepository = MockPicoRepository();
        final useCase = CreateSpotUc(spotRepositoryIMP: mockRepository);
        final mockPico = MockPico();

        when(() => mockRepository.createSpot(mockPico)).thenThrow(Exception("Erro ao criar pico"));
        
        expect(
          () async => await useCase.createSpot(mockPico),
          throwsException,
        );
      });
    });
 }