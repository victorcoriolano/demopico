abstract class ProfileDatabaseService{
  Future<String?> atualizarContribuicoes();
  Future<String?> atualizarSeguidores();
  Future<String?> atualizarBio(String newBio);
  Future<String?> atualizarFoto(String newImg);
  // pegarcONTRIbicoes
}