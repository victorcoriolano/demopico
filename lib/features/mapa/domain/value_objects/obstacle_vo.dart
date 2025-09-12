import 'package:demopico/core/common/errors/domain_failures.dart';
import 'package:demopico/features/mapa/domain/value_objects/modality_vo.dart';

sealed class  ObstacleVo<T> {
  List<String> get options;
  List<String> get selectedValues;
  List<String> get obstacles;
  void selectObstacle(int index);
  void removeObstacle(int value);
}

class ObstacleSkate extends ObstacleVo<ModalitySpot> {
  final List<String> _obstacles;
  final List<String> _selectedObstacles = []; 
  static const Set<String> _options = {
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
      throw ArgumentError("Lista de obstáculos inválida, alguns elementos estão repetidos");
    }
    
    if (!_options.toSet().containsAll(value)){
       throw ArgumentError('Lista de obstáculos com elementos fora do padrão');
    }
   return ObstacleSkate._(value);
  }

  @override
  List<String> get options => _options.toList();
  
  @override
  List<String> get selectedValues => _selectedObstacles;


  
  @override
  void selectObstacle(int index) {
    if (_options.elementAtOrNull(index) == null || _options.elementAt(index).isEmpty  ){
      throw InvalidObstacleFailure(message: "Index inválido");
    }
    _selectedObstacles.add(_options.elementAt(index));
  }

   @override
  void removeObstacle(int index) {
    if (_options.elementAtOrNull(index) == null || _options.elementAt(index).isEmpty  ){
      throw InvalidObstacleFailure(message: "Index inválido");
    }
    _selectedObstacles.remove(_options.elementAt(index));
  }
  
  @override
  List<String> get obstacles => _obstacles.toList();
} 

class ObstacleParkour extends ObstacleVo<ModalitySpot> {
  final List<String> _obstacles;
  final List<String> _selectedObstacles = []; 
  static const Set<String> _options = {
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
      throw ArgumentError("Lista de obstáculos inválida, alguns elementos estão repetidos");
    }
    
    if (!_options.toSet().containsAll(value)){
       throw ArgumentError('Lista de obstáculos com elementos fora do padrão');
    }
   return ObstacleParkour._(value);
  }

  @override
  List<String> get options => _options.toList();
  
  @override
  List<String> get selectedValues => _selectedObstacles;


  
  @override
  void selectObstacle(int index) {
    if (_options.elementAtOrNull(index) == null || _options.elementAt(index).isEmpty  ){
      throw InvalidObstacleFailure(message: "Index inválido");
    }
    _selectedObstacles.add(_options.elementAt(index));
  }

   @override
  void removeObstacle(int index) {
    if (_options.elementAtOrNull(index) == null || _options.elementAt(index).isEmpty  ){
      throw InvalidObstacleFailure(message: "Index inválido");
    }
    _selectedObstacles.remove(_options.elementAt(index));
  }
  
  @override
  List<String> get obstacles => _obstacles.toList();
} 

class ObstacleBMX extends ObstacleVo<ModalitySpot> {
  final List<String> _obstacles;
  final List<String> _selectedObstacles = []; 
  static const Set<String> _options = {
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
    
    if (!_options.toSet().containsAll(value)){
       throw ArgumentError('Lista de obstáculos com elementos fora do padrão');
    }
   return ObstacleBMX._(value);
  }

  @override
  List<String> get options => _options.toList();
  
  @override
  List<String> get selectedValues => _selectedObstacles;


  
  @override
  void selectObstacle(int index) {
    if (_options.elementAtOrNull(index) == null || _options.elementAt(index).isEmpty  ){
      throw InvalidObstacleFailure(message: "Index inválido");
    }
    _selectedObstacles.add(_options.elementAt(index));
  }

   @override
  void removeObstacle(int index) {
    if (_options.elementAtOrNull(index) == null || _options.elementAt(index).isEmpty  ){
      throw InvalidObstacleFailure(message: "Index inválido");
    }
    _selectedObstacles.remove(_options.elementAt(index));
  }
  
  @override
  List<String> get obstacles => _obstacles.toList();
} 



