abstract class IMessageDatasource<DTO> {
    Stream<List<DTO>> watchMessagesForChat(String idChat);
    Future<List<DTO>> getChatForUser(String idUser);
    Future<DTO> getMessageById(String idChat, String idMessage);
    Future<DTO> createChat(DTO initialChat);
    Future<DTO> createGroupChat(DTO initialChat);
    Future<DTO> sendMessage(String idChat, DTO message);
    Future<void> readMessage(String idChat, DTO message);
}