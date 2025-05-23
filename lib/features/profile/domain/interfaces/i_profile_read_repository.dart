import 'package:demopico/features/user/domain/models/user.dart';

abstract class IProfileReadRepository{  
  Future<int> pegarContribuicoes(UserM userModel);
  Future<int> pegarSeguidores(UserM userModel);
  Future<String> pegarBio(UserM userModel);
  Future<String> pegarFoto(UserM userModel);
}