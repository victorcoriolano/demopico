
import 'package:demopico/features/mapa/domain/models/pico_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mocks/mocks_spots.dart' as spots_mock; 

//TODO CORRIGIR ESSES TESTES

void main() {
  group('Deve fazer uma avaliação correta e atualizar o spot ', () {
    test('deve fazer uma avaliação inicial', () async {
      final spotRatingZero = spots_mock.testPico.copyWith(nota: 0, avaliacoes: 0);
      

    });
    test('deve fazer uma avaliação com uma avaliação já feita', () async {

    });
  });  
}