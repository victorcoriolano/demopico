abstract class IProfileDatabaseReadRepository{  
  Future<String> pegarContribuicoes();
  Future<String> pegarSeguidores();
  Future<String> pegarBio();
  Future<String> pegarFoto();
}