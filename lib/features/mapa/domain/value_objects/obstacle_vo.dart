import 'package:demopico/core/common/errors/domain_failures.dart';
import 'package:demopico/features/mapa/domain/value_objects/modality_vo.dart';
import 'package:flutter/widgets.dart';

sealed class  ObstacleVo<T> {
  List<String> get options;
  List<String> get selectedValues;
  List<String> get obstacles;
  void selectObstacle(String value);
  void removeObstacle(String value);
}

class ObstacleSkate extends ObstacleVo<ModalitySpot> {
  final List<String> _obstacles;
  final List<String> _selectedObstacles = []; 
  static const Set<String> _obstaclesAll = {
  "45° graus",
  "Barreira newjersey",
  "Bowl zão",
  "Banco",
  "Corrimão",
  "Escada",
  "Funbox",
  "Gap",
  "Jump",
  "Megaramp",
  "Miniramp",
  "Pirâmide",
  "Quarter",
  "Spine",
  "Stepper",
  "Transição",
  "Hidrante",
  "Parede",
  "Bowl zinho",
  "Lixeira"
};


  ObstacleSkate._(this._obstacles);

  factory ObstacleSkate.fromList(List<String> value){
    final withoutDuplicates = value.toSet();
    if(withoutDuplicates.length < value.length){
      throw ArgumentError("Lista de obstáculos inválida, alguns elementos estão repetidos", value.where((test) => test == test).toString());
    }
    
    if (!_obstaclesAll.toSet().containsAll(value)){
       throw ArgumentError('Lista de obstáculos com elementos fora do padrão', value.where((test) =>_obstaclesAll.contains(test)).toString());
    }
   return ObstacleSkate._(value);
  }

  @override
  List<String> get options => _obstaclesAll.toList();
  
  @override
  List<String> get selectedValues => _selectedObstacles;


  
  @override
  void selectObstacle(String value) {
    if (value.isEmpty || !_obstaclesAll.contains(value)){
      throw ArgumentError("Value inválido", value);
    }
    _selectedObstacles.add(value);
    debugPrint("Selecionou o obstaculo: $value");
  }

   @override
  void removeObstacle(String value) {
    if (value.isEmpty || !_obstaclesAll.contains(value)){
      throw ArgumentError("Value inválido", value);
    }
    _selectedObstacles.remove(value);
    debugPrint("Removeu o obstaculo: $value");
  }
  
  @override
  List<String> get obstacles => _obstacles;
} 

class ObstacleParkour extends ObstacleVo<ModalitySpot> {
  final List<String> _obstacles;
  final List<String> _selectedObstacles = []; 
  static const Set<String> _obstaclesAll = {
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
};


  ObstacleParkour._(this._obstacles);

  factory ObstacleParkour.fromList(List<String> value){
    final withoutDuplicates = value.toSet();
    if(withoutDuplicates.length < value.length){
      throw ArgumentError("Lista de obstáculos inválida, alguns elementos estão repetidos", value.where((test) => test == test).toString());
    }
    
    if (!_obstaclesAll.toSet().containsAll(value)){
       throw ArgumentError('Lista de obstáculos com elementos fora do padrão', value.where((test) =>_obstaclesAll.contains(test)).toString());
    }
   return ObstacleParkour._(value);
  }

  @override
  List<String> get options => _obstaclesAll.toList();
  
  @override
  List<String> get selectedValues => _selectedObstacles;


  
 @override
  void selectObstacle(String value) {
    if (value.isEmpty || !_obstaclesAll.contains(value)){
      throw InvalidObstacleFailure(message: "Value inválido");
    }
    _selectedObstacles.add(value);
    debugPrint("Selecionou o obstaculo: $value");
  }

   @override
  void removeObstacle(String value) {
    if (value.isEmpty || !_obstaclesAll.contains(value)){
      throw InvalidObstacleFailure(message: "Value inválido");
    }
    _selectedObstacles.remove(value);
    debugPrint("Removeu o obstaculo: $value");
  }
  
  @override
  List<String> get obstacles => _obstacles.toList();
} 

class ObstacleBMX extends ObstacleVo<ModalitySpot> {
  final List<String> _obstacles;
  final List<String> _selectedObstacles = []; 
  static const Set<String> _obstaclesAll = {
  'Rampa',
  'Quartar Pipe',
  'Spine',
  'Funbox',
  'Jump',
  'Caixote',
  'Escada',
  'Hubba',
  'Corrimão',
  'Miniramp',
  'Bowl'
};


  ObstacleBMX._(this._obstacles);

  factory ObstacleBMX.fromList(List<String> value){
    final withoutDuplicates = value.toSet();
    if(withoutDuplicates.length < value.length){
      throw ArgumentError("Lista de obstáculos inválida, alguns elementos estão repetidos");
    }
    
    if (!_obstaclesAll.toSet().containsAll(value)){
       throw ArgumentError('Lista de obstáculos com elementos fora do padrão');
    }
   return ObstacleBMX._(value);
  }

  @override
  List<String> get options => _obstaclesAll.toList();
  
  @override
  List<String> get selectedValues => _selectedObstacles;


  
  @override
  void selectObstacle(String value) {
    if (value.isEmpty || !_obstaclesAll.contains(value)){
      throw InvalidObstacleFailure(message: "Value inválido");
    }
    _selectedObstacles.add(value);
    debugPrint("Selecionou o obstaculo: $value");
  }

   @override
  void removeObstacle(String value) {
    if (value.isEmpty || !_obstaclesAll.contains(value)){
      throw InvalidObstacleFailure(message: "Value inválido");
    }
    _selectedObstacles.remove(value);
    debugPrint("Removeu o obstaculo: $value");
  }
  
  @override
  List<String> get obstacles => _obstacles.toList();
} 



