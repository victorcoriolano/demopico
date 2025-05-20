abstract class IProfileDatabaseReadRepository{  
  Future<int> pegarContribuicoes(String uid);
  Future<int> pegarSeguidores(String uid);
  Future<String> pegarBio(String uid);
  Future<String> pegarFoto(String uid);
}