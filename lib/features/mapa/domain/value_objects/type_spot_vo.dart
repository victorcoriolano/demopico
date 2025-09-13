import 'package:demopico/features/mapa/domain/value_objects/modality_vo.dart';

sealed class  TypeSpotVo<T> {
  List<String> get options;
  String get selectedValue;
  TypeSpotVo selectValue(String newValue);

}

class TypeSkate extends TypeSpotVo<ModalitySpot> {
  final String value;
  static const List<String> _options = ['Pico de rua', 'Half', 'Bowl', 'Street', 'SkatePark'];

  TypeSkate._({required this.value});

  factory TypeSkate(String value){
    if (!_options.contains(value)){
       throw ArgumentError('Invalid value for TypeSkate');
    }
   return TypeSkate._(value: value);
  }

  factory TypeSkate.initial() {
    return TypeSkate._(value: _options.first);
  }

  TypeSkate copyWith({required String? newValue}){
    return TypeSkate(newValue ?? value);
  }

  @override
  List<String> get options => _options;
  
  @override
  String get selectedValue => value;
  
  @override
  TypeSpotVo selectValue(String newValue) {
    return copyWith(newValue: newValue);
  }

} 

class TypeParkour extends TypeSpotVo {
  final String value;
  static const List<String> _options = ['Indoor', 'Outdoor', ];

  TypeParkour._({required this.value});

  factory TypeParkour(String value){
    if (_options.contains(value)){
      return TypeParkour._(value: value);
    }
    throw ArgumentError('Invalid value for TypeParkour');
  }

  @override
  List<String> get options => _options;

  @override
  String get selectedValue => value;
  
  @override
  TypeSpotVo selectValue(String newValue) {
    return copyWith(newValue: newValue);
  }

  TypeParkour copyWith({required String? newValue}){
    return TypeParkour(newValue ?? value);
  }
}

class TypeBMX extends TypeSpotVo {
  final String value;
  static const List<String> _options = ['Street', 'Park', 'Vert', 'Pump Track', 'Dirt Jump'];

  TypeBMX._({required this.value});

  factory TypeBMX(String value){
    if (_options.contains(value)){
      return TypeBMX._(value: value);
    }
    throw ArgumentError('Invalid value for TypeBMX');
  }

  TypeParkour copyWith({required String? newValue}){
    return TypeParkour(newValue ?? value);
  }

  @override
  List<String> get options => _options;

  @override
  String get selectedValue => value;
  
  @override
  TypeSpotVo selectValue(String newValue) {
    return copyWith(newValue: newValue);
  }
}



