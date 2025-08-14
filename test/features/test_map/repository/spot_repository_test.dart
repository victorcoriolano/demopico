import 'dart:async';

import 'package:demopico/core/common/files_manager/mappers/i_mapper_dto.dart';
import 'package:demopico/features/external/datasources/firebase/dto/firebase_dto_mapper.dart';
import 'package:demopico/features/mapa/data/data_sources/remote/firebase_spot_remote_datasource.dart';
import 'package:demopico/features/external/datasources/firebase/dto/firebase_dto.dart';
import 'package:demopico/features/mapa/data/repositories/spot_repository_impl.dart';
import 'package:demopico/features/mapa/domain/models/pico_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/mocks_spots.dart';

//cirando anotação para criar o mock

class MockDatasource extends Mock implements FirebaseSpotRemoteDataSource {
  @override
  Future<void> update(FirebaseDTO pico) {
    return Future.value();
  }
}

void main() {
  
  group("Deve testar a interação com o firebase ", () {
    late IMapperDto mapperDto;

    //variáveis mockadas para utilizar nos testes

    late MockDatasource mockDatasource;
    late SpotRepositoryImpl repositoryImpl;

    final testPicoNotaNova = testPico.copyWith(nota: 5, numeroAvaliacoes: 11);

    //setando os mocks para utilizar nos testes
    setUpAll(() {
      mockDatasource = MockDatasource();
      repositoryImpl = SpotRepositoryImpl(mockDatasource);
      mapperDto = FirebaseDtoMapper<PicoModel>(
        fromJson: (data, id) => PicoModel.fromJson(data, id),
        toMap: (model) => model.toMap(),
        getId: (model) => model.id,
      );

      registerFallbackValue(mapperDto.toDTO(testPico));
    });

    //testando criar pico
    test("deve criar um pico com sucesso e retornar a instancia como pico",
        () async {
      // criando fluxo que ocorrerá se der tudo certo
       when(() => mockDatasource.create(any<FirebaseDTO>()))
          .thenAnswer((_) => Future.value(mapperDto.toDTO(testPico))); 

      //chamando o método
      final result = await repositoryImpl.createSpot(testPico);

      //verificando os resultados
      expect(result, isA<PicoModel>());
      expect(result.id, "1");
      expect(result.picoName, "Pico Legal");
    });

    test("deve criar uma stream e retornar os dados do datasource", () {
      when(() => mockDatasource.load())
          .thenAnswer((_) => Stream.value(listDto));

      final result = repositoryImpl.watchListSpots();
      expect(result, isA<Stream<List<PicoModel>>>());

      //verificando se retora a lista de picos
      expectLater(
        result,
        emitsInOrder([
          isA<List<PicoModel>>()
              .having((lista) => lista.length, "deve conter 3", equals(3)),
        ]),
      );
    });

    test("deve atualizar um pico", () async {
 
      final result = await repositoryImpl.updateSpot(testPicoNotaNova);
      expect(result, isA<PicoModel>());

    });

    test("deve deletar um spot", () {
      when(() => mockDatasource.delete(any())).thenAnswer((_) async {});
      repositoryImpl.deleteSpot("1");
      verify(() => mockDatasource.delete("1")).called(1);
    });
  });
}

