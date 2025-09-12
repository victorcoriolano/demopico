
import 'package:flutter_test/flutter_test.dart';

import '../../../mocks/mocks_spots.dart' as spots_mock; 


void main() {
  group('Deve fazer uma avaliação correta e atualizar o spot ', () {
    test('deve fazer uma avaliação inicial', () async {
      final spotRatingZero = spots_mock.testPico.copyWith(nota: 0, numeroAvaliacoes: 0);
      spotRatingZero.updateNota(0.2);
      expect(spotRatingZero.rating, equals(0.2));
      expect(spotRatingZero.numberOfReviews, equals(1) );
    });
    test('deve fazer uma avaliação com uma avaliação já feita', () async {
      spots_mock.testPico2.updateNota(5.0);
      expect(spots_mock.testPico2.rating, equals(4.55));
    });
  });  
}