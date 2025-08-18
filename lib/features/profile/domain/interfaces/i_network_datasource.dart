abstract class INetworkDatasource<DTO> {
  Future<List<DTO>> getConnections(String userID);
  Future<void> connectionUser(DTO dto);
  Future<void> disconnectionUser(DTO dto);
}