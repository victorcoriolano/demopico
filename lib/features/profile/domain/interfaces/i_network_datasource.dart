abstract class INetworkDatasource<DTO> {
  // pegar os relacionamentos independente do status ou do atributo de filtro 
  // para pegar as requisições vai ser tipo "requesterUserID" |"valor do user id"| status | pending
  //para pegar as requisições enviadas pelo user vai ser tipo "addresseeID" | "valor do user id"| status | pending
  // para pegar as conexões feitas vai ser tipo "requesterUserID" | "valor do user id"| status | accepted
  Future<List<DTO>> getRelactionships({
    required String fieldRequest, 
    required String valueID, 
    required String fieldOther, 
    required String valorDoStatus});

  // para criar 
  Future<DTO> createConnection(DTO dto);
  // para deletar conexão 
  Future<void> deleteConnection(String id);
  // para atualizar: recusar, aceitar.
  Future<DTO> updateConnection(DTO dto);
}
