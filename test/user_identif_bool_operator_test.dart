import 'package:demopico/core/common/auth/domain/entities/user_identification.dart';
import 'package:test/test.dart';

void main() {
  group('Teste de igualdade e hashCode da classe Pessoa', () {
    test('Objetos com os mesmos valores devem ser iguais', () {
      final p1 = UserIdentification(name: 'Gabriel', id: "gabi", profilePictureUrl: "url");
      final p2 = UserIdentification(name: 'Gabriel', id: "gabi", profilePictureUrl: "url");

      expect(p1 == p2, isTrue, reason: 'Objetos com o mesmo conteúdo devem ser iguais');
      expect(p1.hashCode, equals(p2.hashCode), reason: 'hashCode deve ser igual quando o conteúdo é igual');
    });

    test('Objetos com valores diferentes não devem ser iguais', () {
      final p1 = UserIdentification(name: 'Gabriel', id: "gabi", profilePictureUrl: "url");
      final p2 = UserIdentification(name: 'Lucas', id: 'gabi', profilePictureUrl: 'url ');

      expect(p1 == p2, isFalse, reason: 'Objetos com conteúdo diferente não devem ser iguais');
      expect(p1.hashCode == p2.hashCode, isFalse, reason: 'hashCode deve ser diferente para objetos diferentes');
    });

    test('Dois objetos idênticos (mesma referência) são sempre iguais', () {
      final p1 = UserIdentification(name: 'Gabriel', id: "gabi", profilePictureUrl: "url");
      final p2 = p1; // mesma referência

      expect(identical(p1, p2), isTrue);
      expect(p1 == p2, isTrue);
      expect(p1.hashCode, equals(p2.hashCode));
    });

    test('Objetos iguais devem funcionar corretamente em coleções baseadas em hash', () {
      final p1 = UserIdentification(name: 'Gabriel', id: "gabi", profilePictureUrl: "url");
      final p2 = UserIdentification(name: 'Gabriel', id: "gabi", profilePictureUrl: "url");

      final conjunto = {p1};
      expect(conjunto.contains(p2), isTrue, reason: 'Set deve reconhecer objetos iguais');
    });
  });
}
