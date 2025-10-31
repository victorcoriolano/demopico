import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demopico/core/common/auth/domain/entities/coletivo_entity.dart';
import 'package:demopico/core/common/auth/domain/entities/user_identification.dart';
import 'package:demopico/core/common/mappers/i_mapper_dto.dart';
import 'package:demopico/features/external/datasources/firebase/dto/firebase_dto.dart';
import 'package:demopico/features/profile/domain/models/notification.dart';
import 'package:demopico/features/profile/domain/models/post.dart';
import 'package:demopico/features/user/domain/models/user_model.dart';

class FirebaseDtoMapper<Model> implements IMapperDto<Model, FirebaseDTO> {

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
  Model toModel(FirebaseDTO dto) {
    return fromJson(dto.data, dto.id);
  }
  
  @override
  FirebaseDTO toDTO(Model model) {
    return FirebaseDTO(id: getId(model), data: toMap(model));
  }

}


/// Mapper para [UserIdentification]
/// Mapeia 1:1 um documento de usuário para a entidade.
final userIdentificationMapper = FirebaseDtoMapper<UserIdentification>(
  fromJson: (map, id) => UserIdentification.fromJson(map..['id'] = id),
  toMap: (model) => model.toJson(),
  getId: (model) => model.id,
);

/// Mapper para [Post]
/// Mapeia 1:1 um documento de post para a entidade.
final postMapper = FirebaseDtoMapper<Post>(
  fromJson: (map, id) => Post.fromJson(map, id),
  toMap: (model) => model.toJson(),
  getId: (model) => model.id,
);

/// Mapper "Parcial" para [ColetivoEntity]
/// Este mapper lida apenas com os dados DENTRO do documento do coletivo.
/// Ele NÃO busca subcoleções ou referências.
final coletivoDtoMapper = FirebaseDtoMapper<ColetivoEntity>(
  // fromJson: Converte DTO -> Entidade Parcial
  // As referências são mapeadas como IDs (Strings) e as listas (subcoleções) vêm vazias.
  fromJson: (map, id) {
    // Resolve as referências para IDs
    final resolvedData = FirebaseDTO(id: id, data: map)
        .resolveReference('modarator')
        .resolveReferencesList('members')
        .data;

    return ColetivoEntity(
      id: id,
      nameColetivo: resolvedData['nameColetivo'] ?? '',
      logo: resolvedData['logo'] ?? '',
      guests: List<String>.from(resolvedData['guests'] ?? []) ,
      entryRequests: List<String>.from(resolvedData['entryRequests'] ?? []),
      // Mapeia a ID do moderador para um UserIdentification "parcial"
      modarator: UserIdentification(
        id: resolvedData['modarator'] ?? '',
        name: '', // Será preenchido pelo Repository
        profilePictureUrl: null, // Será preenchido pelo Repository
      ),
      
      // Mapeia as IDs dos membros para UserIdentification "parciais"
      members: (List<String>.from(resolvedData['members'] ?? []))
          .map((memberId) => UserIdentification(
                id: memberId,
                name: '', // Será preenchido pelo Repository
                profilePictureUrl: null, // Será preenchido pelo Repository
              ))
          .toList(),

      // A subcoleção de publicações virá vazia por padrão
      publications: [],
    );
  },

  // toMap: Converte Entidade -> DTO (para escrita)
  // Converte os objetos UserIdentification de volta para DocumentReferences.
  toMap: (model) {
    return {
      'entryRequests': model.entryRequests,
      'guests': model.guests,
      'nameColetivo': model.nameColetivo,
      'logo': model.logo,
      // Inserindo referencia ao invés dos dados exatos
      'modarator':
          FirebaseFirestore.instance.collection('users').doc(model.modarator.id),
      'members': model.members
          .map((user) =>
              user.id)
          .toList(),
      // 'publications' não é armazenado no documento principal.
    };
  },
  getId: (model) => model.id,
);


final mapperUserModel = FirebaseDtoMapper<UserM>(
    fromJson: (data, id) => UserM.fromJson(data, id),
    toMap: (user) => user.toJson(),
    getId: (model) => model.id);



// mapper notification 
final mapperNotificationModel = FirebaseDtoMapper<NotificationItem>(
  fromJson: (map, id) => NotificationItem.fromMap(map..["id"] = id),
  toMap: (model) => model.toJson(),
  getId: (model) => model.id,
  );