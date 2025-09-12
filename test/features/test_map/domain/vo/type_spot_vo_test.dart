import 'package:flutter_test/flutter_test.dart';
import 'package:demopico/features/mapa/domain/value_objects/type_spot_vo.dart';

void main() {
  group('TypeSkate', () {
    test('should create with valid value', () {
      final type = TypeSkate('Street');
      expect(type.selectedValue, 'Street');
      expect(type.options, contains('Street'));
    });

    test('should throw with invalid value', () {
      expect(() => TypeSkate('Invalid'), throwsArgumentError);
    });
  });

  group('TypeParkour', () {
    test('should create with valid value', () {
      final type = TypeParkour('Indoor');
      expect(type.selectedValue, 'Indoor');
      expect(type.options, contains('Indoor'));
    });

    test('should throw with invalid value', () {
      expect(() => TypeParkour('Invalid'), throwsArgumentError);
    });
  });

  group('TypeBMX', () {
    test('should create with valid value', () {
      final type = TypeBMX('Park');
      expect(type.selectedValue, 'Park');
      expect(type.options, contains('Park'));
    });

    test('should throw with invalid value', () {
      expect(() => TypeBMX('Invalid'), throwsArgumentError);
    });
  });
}