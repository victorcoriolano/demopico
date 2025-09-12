

  import 'package:demopico/core/common/errors/domain_failures.dart';

  sealed class  AttributesVO {
    Map<String, int> get attributes;
    AttributesVO updateRate(dynamic attributeName, int newRate);

    const AttributesVO();
  }

  class SkateAttributes extends AttributesVO {
    final Map<SkateAttributesEnum, int> _attributes;

    const SkateAttributes._(this._attributes);

    factory SkateAttributes.initial() => SkateAttributes._({
      SkateAttributesEnum.conditionGround: 2,
      SkateAttributesEnum.lighting: 3,
      SkateAttributesEnum.policing: 3,
      SkateAttributesEnum.footTraffic: 3,
      SkateAttributesEnum.kickOut: 3,
    });

    factory SkateAttributes.fromMap(Map<String, dynamic> map) {
      if (map.isEmpty) {
        throw InvalidAttributeError(message: 'Mapa de atributos vindo do DB está vazio.');
      }

      final converted = <SkateAttributesEnum, int>{};

      for (final entry in map.entries) {
        SkateAttributesEnum key;
        try {
          key = SkateAttributesEnum.fromString(entry.key);
        } on InvalidAttributeError catch (e) {
          throw InvalidAttributeError(message: 'Chave inválida no map do DB: ${entry.key}. ${e.message}');
        }

        final rawValue = entry.value;
        if (rawValue == null) {
          throw InvalidAttributeError(message: 'Valor nulo para atributo ${entry.key}.');
        }

        int value;
        if (rawValue is num) {
          value = rawValue.toInt();
        } else if (rawValue is String) {
          value = int.tryParse(rawValue) ??
              (throw InvalidAttributeError(message: 'Valor para ${entry.key} não é um número: "$rawValue".'));
        } else {
          throw InvalidAttributeError(message: 'Tipo do valor inválido para ${entry.key}: ${rawValue.runtimeType}.');
        }

        converted[key] = value;
      }

      return SkateAttributes(converted); // irá validar via factory
    }

      /// Cria a instância a partir de um Map já tipado - valida estritamente
    factory SkateAttributes(Map<SkateAttributesEnum, int> attributes) {
      _validateAttributesMap(attributes);
      // garante imutabilidade externa
      return SkateAttributes._(Map.unmodifiable(attributes));
    }

    @override
    SkateAttributes updateRate(dynamic attribute, int newRate) {
          if (newRate < 1.0 || newRate > 5.0) {
        throw InvalidAttributeError(message: 'New rate must be between 1.0 and 5.0.');
      }

      if (attribute is! SkateAttributesEnum) {
        throw InvalidAttributeError(message: 'Attribute deve ser do tipo SkateAttributesEnum.');
      }

      if (!_attributes.containsKey(attribute)) {
        throw InvalidAttributeError(message: 'Atributo ${attribute.name} não existe para Skate.');
      }
      final updated = Map<SkateAttributesEnum, int>.from(_attributes);
      updated[attribute] = newRate;
      return SkateAttributes._(updated);
    }

    @override
    Map<String, int> get attributes => _attributes.map((entry, value) {
      return MapEntry(entry.name, value);
    } );

    static void _validateAttributesMap(Map<SkateAttributesEnum, int> attributes) {
      if (attributes.isEmpty) {
        throw InvalidAttributeError(message: 'Attributes map cannot be empty.');
      }

      // rango válido
      if (attributes.values.any((rate) => rate < 1.0 || rate > 5.0)) {
        throw InvalidAttributeError(message: 'Rate must be between 1.0 and 5.0.');
      }

      // presença de todos os atributos esperados (e só eles)
      final expected = Set<SkateAttributesEnum>.from(SkateAttributesEnum.values);
      final keys = attributes.keys.toSet();

      if (!keys.containsAll(expected)) {
        final missing = expected.difference(keys).map((e) => e.name).join(', ');
        throw InvalidAttributeError(message: 'Faltando atributos obrigatórios: $missing.');
      }

      if (keys.length != expected.length) {
        // se tem chaves extras
        final extras = keys.difference(expected).map((e) => e.name).join(', ');
        if (extras.isNotEmpty) {
          throw InvalidAttributeError(message: 'Mapa contém atributos extras não esperados: $extras.');
        }
      }
    }
  }


  enum SkateAttributesEnum {
    conditionGround,
    lighting,
    policing,
    footTraffic,
    kickOut;


    factory SkateAttributesEnum.fromString(String name) {
      switch (name) {
        case 'conditionGround':
        case 'Chão':
          return SkateAttributesEnum.conditionGround;
        case 'lighting':
        case 'Iluminação':
          return SkateAttributesEnum.lighting;
        case 'policing':
        case 'Policiamento':
          return SkateAttributesEnum.policing;
        case 'footTraffic':
        case 'Movimento':
          return SkateAttributesEnum.footTraffic;
        case 'kickOut':
        case 'Kick-Out':
          return SkateAttributesEnum.kickOut;
        default:
          throw InvalidAttributeError(message:'Atributo "$name" não encontrado em SkateAttributesEnum.');
      }
    }

    String get name {
      switch (this) {
        case SkateAttributesEnum.conditionGround:
          return 'Chão';
        case SkateAttributesEnum.lighting:
          return 'Iluminação';
        case SkateAttributesEnum.policing:
          return 'Policiamento';
        case SkateAttributesEnum.footTraffic:
          return 'Movimento';
        case SkateAttributesEnum.kickOut:
          return 'Kick-Out';
      }
    }
  }

