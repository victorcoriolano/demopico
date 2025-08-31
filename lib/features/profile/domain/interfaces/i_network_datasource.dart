abstract class INetworkDatasource<DTO> {
  Future<List<DTO>> getConnections(String field, String value);
  Future<List<DTO>> fetchRequestConnections(String userID);
  Future<DTO> createConnection(DTO dto);
  Future<void> disconnectUser(DTO dto);
  Future<DTO> updateConnection(DTO dto);
  Future<DTO> checkConnection(String idConnection);
}