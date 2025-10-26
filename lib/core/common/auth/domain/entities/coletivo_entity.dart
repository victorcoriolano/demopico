
import 'package:demopico/core/common/auth/domain/entities/user_identification.dart';
import 'package:demopico/features/profile/domain/models/post.dart';

class ColetivoEntity {
  final String id;
  final String nameColetivo;
  final UserIdentification modarator;
  final List<UserIdentification> members;
  final String logo;
  final List<Post> publications;
  
  ColetivoEntity(
      {required this.id,
      required this.publications,
      required this.nameColetivo,
      required this.modarator,
      required this.members,
      required this.logo});

  factory ColetivoEntity.initial(String nameColetivo, UserIdentification mod, String logo){
    return ColetivoEntity(
      id: "", 
      publications: [], 
      nameColetivo: nameColetivo, 
      modarator: mod, 
      members: [], 
      logo: logo);
  }

 ColetivoEntity copyWith({
    String? id,
    String? nameColetivo,
    UserIdentification? modarator,
    List<UserIdentification>? members,
    String? logo,
    List<Post>? publications,
  }) {
    return ColetivoEntity(
      id: id ?? this.id,
      nameColetivo: nameColetivo ?? this.nameColetivo,
      modarator: modarator ?? this.modarator,
      members: members ?? List<UserIdentification>.from(this.members),
      logo: logo ?? this.logo,
      publications: publications ?? List<Post>.from(this.publications),
    );
  }
   
}