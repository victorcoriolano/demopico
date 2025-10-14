abstract class IMessageDatasource<DTO> {
    Stream<List<DTO>> getMessagesForChat(String idChat);
    Future<List<DTO>> getChatForUser(String idUser);
    Future<void> sendMessage(String idChat, DTO message);
    Future<void> readMessage(String idChat, DTO message);
}