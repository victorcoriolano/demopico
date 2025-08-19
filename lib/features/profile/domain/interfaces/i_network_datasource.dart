abstract class INetworkDatasource<DTO> {
  Future<List<DTO>> getConnections(String userID);
  Future<List<DTO>> fetchRequestConnections(String userID);
  Future<DTO> connectUser(DTO dto);
  Future<void> disconnectUser(DTO dto);
}