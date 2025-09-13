

  import 'package:demopico/core/common/errors/domain_failures.dart';

  sealed class  AttributesVO {
    Map<String, int> get attributes;
    AttributesVO updateRate(String attributeName, int newRate);
    String obterDescricao(String attribute, int nota);
    List<String> get getAttributesList;
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
    SkateAttributes updateRate(String name, int newRate) {
      final attribute = SkateAttributesEnum.fromString(name);
          if (newRate < 1.0 || newRate > 5.0) {
        throw InvalidAttributeError(message: 'New rate must be between 1.0 and 5.0.');
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
    
      @override
      String obterDescricao(String attribute, int nota) {
        final att = SkateAttributesEnum.fromString(attribute);
        switch (att) {
          
          case SkateAttributesEnum.conditionGround:
            return SkateAttributesEnum.obterDescricaoChao(nota);
          case SkateAttributesEnum.lighting:
            return SkateAttributesEnum.obterDescricaoIluminacao(nota);
          case SkateAttributesEnum.policing:
            return SkateAttributesEnum.obterDescricaoPoliciamento(nota);
          case SkateAttributesEnum.footTraffic:
            return SkateAttributesEnum.obterDescricaoMovimento(nota);
          case SkateAttributesEnum.kickOut:
            return SkateAttributesEnum.obterDescricaoKickOut(nota);
        }
      }
      
        @override
        List<String> get getAttributesList => SkateAttributesEnum.values.map((att) => att.name).toList();
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

    static String obterDescricaoChao(int nota) {
    switch (nota) {
      case 5:
        return 'Patinete';
      case 4:
        return 'Lisinho';
      case 3:
        return 'Suave';
      case 2:
        return 'Pedrinhas';
      case 1:
        return 'Esburacado';
      default:
        return 'Descrição Indefinida';
    }
  }

// Função para mapear os valores de 1 a 5 para a descrição do atributo 'Iluminação'
  static String obterDescricaoIluminacao(int nota) {
    switch (nota) {
      case 5:
        return 'Muito Claro';
      case 4:
        return 'Clarinho';
      case 3:
        return 'Razoável';
      case 2:
        return 'Pouca Luz';
      case 1:
        return 'Escuro';
      default:
        return 'Descrição Indefinida';
    }
  }

// Função para mapear os valores de 1 a 5 para a descrição do atributo 'Policiamento'
  static String obterDescricaoPoliciamento(int nota) {
    switch (nota) {
      case 5:
        return 'Opressão';
      case 4:
        return 'Boqueta';
      case 3:
        return 'Pala';
      case 2:
        return 'Toma Cuidado';
      case 1:
        return 'Suave';
      default:
        return 'Descrição Indefinida';
    }
  }

// Função para mapear os valores de 1 a 5 para a descrição do atributo 'Movimento'
  static String obterDescricaoMovimento(int nota) {
    switch (nota) {
      case 5:
        return 'Muito Cheio';
      case 4:
        return 'Cheio';
      case 3:
        return 'Médio';
      case 2:
        return 'Calmo';
      case 1:
        return 'Vazio';
      default:
        return 'Descrição Indefinida';
    }
  }

// Função para mapear os valores de 1 a 5 para a descrição do atributo 'Kick-Out'
  static String obterDescricaoKickOut(int nota) {
    switch (nota) {
      case 5:
        return 'Muito Capaz';
      case 4:
        return 'Bem Capaz';
      case 3:
        return 'Moderado';
      case 2:
        return 'Improvável';
      case 1:
        return 'Impossível';
      default:
        return 'Descrição Indefinida';
    }
  }
    
  }

