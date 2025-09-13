import 'package:demopico/core/common/errors/domain_failures.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:demopico/features/mapa/domain/value_objects/obstacle_vo.dart';

void main() {
  group('ObstacleParkour', () {
    test('should create ObstacleParkour with valid unique obstacles', () {
      final obstacles = [
        'Muro',
        'Corrimão',
        'Escada',
        'Gap',
        'Telhado',
        'Pilar',
        'Banco',
        'Parede',
        'Grama',
        'Areia'
      ];
      final obstacleParkour = ObstacleParkour.fromList(obstacles);
      expect(obstacleParkour.obstacles, obstacles);
    });

    test('should throw ArgumentError if obstacles have duplicates', () {
      final obstacles = ['Muro', 'Muro', 'Corrimão'];
      expect(
        () => ObstacleParkour.fromList(obstacles),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('should throw ArgumentError if obstacles contain invalid values', () {
      final obstacles = ['Muro', 'Corrimão', 'Invalido'];
      expect(
        () => ObstacleParkour.fromList(obstacles),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('options should contain all valid parkour obstacles', () {
      final options = ObstacleParkour.fromList(['Muro']).options;
      expect(options, containsAll([
        'Muro',
        'Corrimão',
        'Escada',
        'Gap',
        'Telhado',
        'Pilar',
        'Banco',
        'Parede',
        'Grama',
        'Areia'
      ]));
    });

    test('selectObstacle adds the correct obstacle to selectedValues', () {
      final obstacleParkour = ObstacleParkour.fromList(['Muro']);
      obstacleParkour.selectObstacle("Muro"); // 'Muro'
      expect(obstacleParkour.selectedValues, contains('Muro'));
    });

    test('removeObstacle removes the correct obstacle from selectedValues', () {
      final obstacleParkour = ObstacleParkour.fromList(['Muro']);
      obstacleParkour.selectObstacle("Muro"); // 'Muro'
      obstacleParkour.removeObstacle("Muro");
      expect(obstacleParkour.selectedValues, isNot(contains('Muro')));
    });

    test('selectObstacle throws InvalidObstacleFailure for invalid index', () {
      final obstacleParkour = ObstacleParkour.fromList(['Muro']);
      expect(
        () => obstacleParkour.selectObstacle("100"),
        throwsA(isA<InvalidObstacleFailure>()),
      );
    });

    test('removeObstacle throws InvalidObstacleFailure for invalid index', () {
      final obstacleParkour = ObstacleParkour.fromList(['Muro']);
      expect(
        () => obstacleParkour.removeObstacle("100"),
        throwsA(isA<InvalidObstacleFailure>()),
      );
    });
  });
}