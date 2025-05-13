import 'package:demopico/features/user/domain/models/user.dart';

abstract class IProfileDatabaseReadRepository{  
  Future<String?> pegarContribuicoes(UserM user);
  Future<String?> pegarSeguidores(UserM user);
  Future<String?> pegarBio(UserM user);
  Future<String?> pegarFoto(UserM user);
}