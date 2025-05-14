import 'package:demopico/features/user/domain/models/user.dart';

abstract class ProfileDatabaseUpdateRepository {
  void atualizarContribuicoes(UserM user);
  void atualizarSeguidores(UserM user);
  void atualizarBio(String newBio, UserM user);
  void atualizarFoto(String newFoto, UserM user);
}