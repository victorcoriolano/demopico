
// implementa o contrato
import 'package:demopico/core/common/mappers/i_mapper_dto.dart';
import 'package:demopico/features/profile/domain/models/relationship.dart';
import 'package:demopico/features/profile/presentation/view_objects/relationship_vo.dart';

class RelationshipMapper implements IMapperDto<Relationship, RelationshipVo> {

  static RelationshipMapper? _instance;
  static RelationshipMapper get instance {
    _instance ??= RelationshipMapper();
    return _instance!;
  }

  @override
  RelationshipVo toDTO(Relationship model) {
    return RelationshipVo(
      idRelationship: model.id,
      requester: model.requesterUser,
      addressed: model.addressed,
      status: model.status,
      createdAt: model.createdAt,
      updatedAt: model.updatedAt,
    );
  }

  @override
  Relationship toModel(RelationshipVo dto) {
    if (dto.requester is! ConnectionRequester) {
      throw ArgumentError('Requester inválido no RelationshipVo');
    }
    if (dto.addressed is! ConnectionReceiver) {
      throw ArgumentError('Addressed inválido no RelationshipVo');
    }

    return Relationship(
      id: dto.idRelationship,
      requesterUser: dto.requester as ConnectionRequester,
      addressed: dto.addressed as ConnectionReceiver,
      status: dto.status ?? RequestConnectionStatus.pending,
      createdAt: dto.createdAt ?? DateTime.now(),
      updatedAt: dto.updatedAt ?? DateTime.now(),
    );
  }
}
