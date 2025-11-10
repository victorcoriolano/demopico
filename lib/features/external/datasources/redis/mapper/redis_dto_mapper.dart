import 'package:demopico/core/common/mappers/i_mapper_dto.dart';
import 'package:demopico/features/external/datasources/redis/dto/redis_dto.dart';

class RedisDtoMapper<Model> implements IMapperDto<Model, RedisDto> {
  // aplica as funções de comportamento na composição da classe 
  final Model Function(Map<String, dynamic> map) fromJson;
  final Map<String, dynamic> Function(Model model) toMap;


  RedisDtoMapper({
    required this.fromJson,
    required this.toMap,
  });

  @override
  Model toModel(RedisDto dto) {
    return fromJson(dto.data);
  }

  @override
  RedisDto toDTO(Model model) {
    return RedisDto(data: toMap(model));
  }

}