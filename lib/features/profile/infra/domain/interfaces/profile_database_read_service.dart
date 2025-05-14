abstract class ProfileDatabaseReadService {
  Future<String?> pegarContribuicoes(String uid);
  Future<String?> pegarSeguidores(String uid);
  Future<String?> pegarBio(String uid);
  Future<String?> pegarFoto(String uid);
}