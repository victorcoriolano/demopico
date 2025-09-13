

import 'package:demopico/core/common/errors/domain_failures.dart';
import 'package:demopico/features/mapa/domain/value_objects/attributes_vo.dart';
import 'package:test/test.dart';

void main() {
  group('SkateAttributes', () {
    //
    // CASOS DE ACERTO
    //
    test('SkateAttributes.initial() deve criar uma instância válida', () {
      final attributes = SkateAttributes.initial();

      expect(attributes, isA<SkateAttributes>());
      expect(attributes.attributes, isNotEmpty);
      expect(attributes.attributes.length, equals(SkateAttributesEnum.values.length));
    });

    test('updateRate deve retornar uma nova instância com a nota alterada', () {
      final original = SkateAttributes.initial();
      final newRate = 5;
      
      final updated = original.updateRate("Iluminação", newRate);

      // Verifica se é uma nova instância
      expect(original, isNot(same(updated)));
      // Verifica se a nota original não foi alterada
      expect(original.attributes[SkateAttributesEnum.lighting.name], isNot(equals(newRate)));
      // Verifica se a nota na nova instância foi alterada corretamente
      expect(updated.attributes[SkateAttributesEnum.lighting.name], equals(newRate));
      // Verifica se os outros atributos permanecem os mesmos
      expect(updated.attributes[SkateAttributesEnum.policing.name], equals(original.attributes[SkateAttributesEnum.policing.name]));
    });

    //
    // CASOS DE ERRO
    //
    test('O construtor factory deve lançar InvalidAttributeError se o mapa for vazio', () {
      expect(() => SkateAttributes.fromMap({}), throwsA(isA<InvalidAttributeError>()));
    });
    
    test('O construtor factory deve lançar ArgumentError se alguma nota for inválida', () {
      final invalidMap = {
        SkateAttributesEnum.conditionGround.name: 6.0,
        SkateAttributesEnum.lighting.name: 3.0,
        SkateAttributesEnum.policing.name: 3.0,
        SkateAttributesEnum.footTraffic.name: 3.0,
        SkateAttributesEnum.kickOut.name: 3.0,
      };
      expect(() => SkateAttributes.fromMap(invalidMap), throwsA(isA<InvalidAttributeError>()));
    });

    test('O construtor factory deve lançar InvalidAttributeError se os atributos estiverem incompletos', () {
      final incompleteMap = {
        SkateAttributesEnum.conditionGround.name: 2.0,
        SkateAttributesEnum.lighting.name: 3.0,
        SkateAttributesEnum.policing.name: 3.0,
      };
      expect(() => SkateAttributes.fromMap(incompleteMap), throwsA(isA<InvalidAttributeError>()));
    });

    test('updateRate deve lançar InvalidAttributeError se a nova nota for inválida', () {
      final attributes = SkateAttributes.initial();
      expect(() => attributes.updateRate("Iluminação", 6), throwsA(isA<InvalidAttributeError>()));
    });
  });
}