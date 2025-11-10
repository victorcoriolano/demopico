import 'package:demopico/features/mapa/domain/value_objects/rating_vo.dart';
import 'package:flutter_test/flutter_test.dart';

  void main() {
    group("Deve testar a avaliação do spot", () {
      test('deve fazer uma avaliação inicial', () async {
        final rate = RatingVo(0.0, 0);
        
        final update = rate.calculateNewAverage(0.2);
        expect(update.average, equals(0.2));
        expect(update.numberOfReviews, equals(1));
      });
      test('deve fazer uma avaliação com uma avaliação já feita', () async {
        final rate = RatingVo(4.5, 10);
        final update = rate.calculateNewAverage(5.0);
        expect(update.average, equals(4.55));
      });
    });

    group("Deve testar o lançamento de excessões ", () {
       test('deve lançar exceção ao criar com rating inválido (< 0)', () {
      expect(() => RatingVo(-1.0, 0), throwsArgumentError);
    });

    test('deve lançar exceção ao criar com rating inválido (> 5)', () {
      expect(() => RatingVo(5.5, 0), throwsArgumentError);
    });

    test('deve lançar exceção ao criar com número de reviews negativo', () {
      expect(() => RatingVo(0.0, -1), throwsArgumentError);
    });

    test('deve lançar exceção ao criar com média > 0 mas sem reviews', () {
      expect(() => RatingVo(3.0, 0), throwsArgumentError);
    });

    test('deve lançar exceção ao calcular nova média com rating < 0', () {
      final rate = RatingVo(0.0, 0);
      expect(() => rate.calculateNewAverage(-0.1), throwsArgumentError);
    });

    test('deve lançar exceção ao calcular nova média com rating > 5', () {
      final rate = RatingVo(0.0, 0);
      expect(() => rate.calculateNewAverage(5.5), throwsArgumentError);
    });
    });
  }