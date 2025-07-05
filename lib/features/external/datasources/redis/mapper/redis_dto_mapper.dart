import 'package:demopico/core/common/files/mappers/i_mapper_dto.dart';
import 'package:demopico/features/external/datasources/redis/dto/redis_dto.dart';

class RedisDtoMapper<Model> implements IMapperDto<Model, RedisDto> {
  // aplica as funções de comportamento na composição da classe 
  final Model Function(Map<String, dynamic> map, String id) fromJson;
  final Map<String, dynamic> Function(Model model) toMap;
  final String Function(Model model) getId;

  RedisDtoMapper({
    required this.fromJson,
    required this.toMap,
    required this.getId,
  });

  @override
  Model toModel(RedisDto dto) {
    return this.fromJson(dto.data, dto.id);
  }

  @override
  RedisDto toDTO(Model model) {
    return RedisDto(id: getId(model), data: toMap(model));
  }

}