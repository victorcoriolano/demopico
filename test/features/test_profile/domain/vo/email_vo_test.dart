import 'package:flutter_test/flutter_test.dart';
import 'package:demopico/core/common/auth/domain/value_objects/email_vo.dart';
import 'package:demopico/core/common/errors/repository_failures.dart';

void main() {
  group('EmailVO', () {
    test('should create EmailVO with valid email', () {
      final email = 'dasaybarreto@gmail.com ';
      final vo = EmailVO(email);
      expect(vo.value, 'dasaybarreto@gmail.com');
    });

    test('should throw InvalidEmailFailure for invalid email', () {
      expect(() => EmailVO('invalid-email'), throwsA(isA<InvalidEmailFailure>()));
      expect(() => EmailVO('test@'), throwsA(isA<InvalidEmailFailure>()));
      expect(() => EmailVO('test@.com'), throwsA(isA<InvalidEmailFailure>()));
      expect(() => EmailVO(''), throwsA(isA<InvalidEmailFailure>()));
      expect(() => EmailVO('test@com'), throwsA(isA<InvalidEmailFailure>()));
    });

    test('should create empty EmailVO using EmailVO.empty()', () {
      final vo = EmailVO.empty();
      expect(vo.value, '');
    });

    test('should trim and lowercase email', () {
      final email = '  USER@DOMAIN.COM  ';
      final vo = EmailVO(email);
      expect(vo.value, 'user@domain.com');
    });
  });
}