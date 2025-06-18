import 'package:demopico/core/common/data/interfaces/datasource/i_mapper_dto.dart';
import 'package:demopico/core/common/data/dtos/firebase_dto.dart';


/// classe de mapeamento de dados do firebase
/// representa o concrete strategy do strategy pattern
/// o comportamente é injetado no construtor da classe
/// para as classes que implementam o IMapperDto poderem injetar o comportamento
/// de mapeamento de dados
/// assim não precisamos de diversos mappers pq os comportamentos são injetados

class FirebaseDtoMapper<Model> implements IMapperDto<FirebaseDTO, Model> {

  // aplica as funções de comportamento na composição da classe 
  final Model Function (Map<String, dynamic> map, String id) fromJson;
  final Map<String, dynamic> Function (Model model) toMap;
  final String Function (Model model) getId;

  FirebaseDtoMapper({
    required this.fromJson,
    required this.toMap,
    required this.getId,
  });


  @override
  Model fromDto(FirebaseDTO dto) {
    return this.fromJson(dto.data, dto.id);
  }

  @override
  FirebaseDTO toDTO(Model model) {
    return FirebaseDTO(id: getId(model), data: toMap(model));
  }

}