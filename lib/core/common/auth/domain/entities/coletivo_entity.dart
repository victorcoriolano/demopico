
import 'package:demopico/core/common/auth/domain/entities/user_identification.dart';
import 'package:demopico/features/profile/domain/models/post.dart';

class ColetivoEntity {
  final String id;
  final String nameColetivo;
  
  final UserIdentification modarator;
  final List<UserIdentification> members;
  final List<String> entryRequests; // lista de ids que solicitaram a entrada no coletivo;
  final List<String> guests; // lista de  usuários convidados a entrar;
  final String logo;
  final List<Post> publications;
  
  ColetivoEntity(
      {required this.id,
      required this.entryRequests,
      required this.guests,
      required this.publications,
      required this.nameColetivo,
      required this.modarator,
      required this.members,
      required this.logo});

  factory ColetivoEntity.initial(String nameColetivo, UserIdentification mod, String logo, [List<String>? guests]){
    return ColetivoEntity(
      id: "", 
      publications: [], 
      nameColetivo: nameColetivo, 
      modarator: mod, 
      members: [mod], 
      logo: logo,
      guests: guests ?? [],
      entryRequests: [],
    );
  }

 ColetivoEntity copyWith({
    String? id,
    String? nameColetivo,
    UserIdentification? modarator,
    List<UserIdentification>? members,
    String? logo,
    List<Post>? publications,
    List<String>? guests,
    List<String>? entryRequests,
  }) {
    return ColetivoEntity(
      entryRequests: entryRequests ?? this.entryRequests,
      guests: guests ?? this.guests,
      id: id ?? this.id,
      nameColetivo: nameColetivo ?? this.nameColetivo,
      modarator: modarator ?? this.modarator,
      members: members ?? List<UserIdentification>.from(this.members),
      logo: logo ?? this.logo,
      publications: publications ?? List<Post>.from(this.publications),
    );
  }

  UserCollectiveRole ruleForUser(String userID){
    if (entryRequests.contains(userID)){
      return UserCollectiveRole.pending;
    }

    if (members.map((element) => element.id).contains(userID) && modarator.id != userID){
      return UserCollectiveRole.member;
    }

    if (modarator.id == userID){
      return UserCollectiveRole.moderator;
    }

    return UserCollectiveRole.visitor;
  }
   
}


enum UserCollectiveRole {
  visitor,
  member,
  moderator,
  pending, 
}