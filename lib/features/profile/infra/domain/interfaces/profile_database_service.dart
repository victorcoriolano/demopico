abstract class ProfileDatabaseService{
  Future<String?> atualizarContribuicoes(String uid);
  Future<String?> atualizarSeguidores(String uid);
  Future<String?> atualizarBio(String newBio, String uid);
  Future<String?> atualizarFoto(String newImg, String uid);
  // pegarcONTRIbicoes
}